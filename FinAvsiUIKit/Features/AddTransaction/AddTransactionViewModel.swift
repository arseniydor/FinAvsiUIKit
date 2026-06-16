//
//  AddTransactionViewModel.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

protocol AddTransactionViewModelDelegate: AnyObject {
    func addTransactionViewModelDidSave(_ viewModel: AddTransactionViewModel)
    func addTransactionViewModel(_ viewModel: AddTransactionViewModel, didFailWith message: String)
}

final class AddTransactionViewModel {
    weak var delegate: AddTransactionViewModelDelegate?

    private let router: AddTransactionRouting
    private let transactionService: TransactionServiceProtocol

    init(router: AddTransactionRouting, transactionService: TransactionServiceProtocol) {
        self.router = router
        self.transactionService = transactionService
    }

    func saveButtonTapped(
        title: String,
        amount: Double,
        type: TransactionType,
        category: String,
        description: String?,
        paymentMethod: PaymentMethod,
        date: Date
    ) {
        let transaction = Transaction(
            id: UUID(),
            amount: amount,
            type: type,
            category: category,
            title: title,
            description: description,
            paymentMethod: paymentMethod,
            date: date,
            createdAt: Date(),
            updatedAt: Date()
        )

        do {
            try transactionService.createTransaction(transaction)
            delegate?.addTransactionViewModelDidSave(self)
            router.close()
        } catch {
            delegate?.addTransactionViewModel(self, didFailWith: "Failed to save transaction")
        }
    }

    func cancelButtonTapped() {
        router.close()
    }
}
