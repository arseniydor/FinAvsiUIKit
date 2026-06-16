//
//  EditTransactionViewModel.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

protocol EditTransactionViewModelDelegate: AnyObject {
    func editTransactionViewModel(_ viewModel: EditTransactionViewModel, didLoad transaction: Transaction)

    func editTransactionViewModel(_ viewModel: EditTransactionViewModel, didFailWith message: String)
}

final class EditTransactionViewModel {
    weak var delegate: EditTransactionViewModelDelegate?

    private let router: EditTransactionRouting
    private let transactionService: TransactionServiceProtocol

    private var transaction: Transaction

    init(transaction: Transaction, router: EditTransactionRouting, transactionService: TransactionServiceProtocol) {
        self.transaction = transaction
        self.router = router
        self.transactionService = transactionService
    }

    func viewDidLoad() {
        delegate?.editTransactionViewModel(self, didLoad: transaction)
    }

    func cancelButtonTapped() {
        router.close()
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
        let updatedTransaction = Transaction(
            id: transaction.id,
            amount: amount,
            type: type,
            category: category,
            title: title,
            description: description,
            paymentMethod: paymentMethod,
            date: date,
            createdAt: transaction.createdAt,
            updatedAt: Date()
        )

        do {
            try transactionService.updateTransaction(updatedTransaction)
            transaction = updatedTransaction
            router.close()
        } catch {
            delegate?.editTransactionViewModel(self, didFailWith: "Failed to update transaction")
        }
    }
}
