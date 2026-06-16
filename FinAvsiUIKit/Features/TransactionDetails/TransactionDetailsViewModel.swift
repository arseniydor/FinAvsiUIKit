//
//  TransactionDetailsViewModel.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

protocol TransactionDetailsViewModelDelegate: AnyObject {
    func transactionDetailsViewModel(_ viewModel: TransactionDetailsViewModel, didChangeState state: TransactionDetailsViewState)
}

final class TransactionDetailsViewModel {
    weak var delegate: TransactionDetailsViewModelDelegate?

    private let transactionId: UUID
    private let router: TransactionDetailsRouting
    private let transactionService: TransactionServiceProtocol

    private var transaction: Transaction?

    init(transactionId: UUID, router: TransactionDetailsRouting, transactionService: TransactionServiceProtocol) {
        self.transactionId = transactionId
        self.router = router
        self.transactionService = transactionService
    }

    func viewDidLoad() {
        loadTransaction()
    }

    func viewWillAppear() {
        loadTransaction()
    }

    func editButtonTapped() {
        guard let transaction else { return }
        router.showEditTransaction(transaction)
    }

    private func loadTransaction() {
        do {
            let transaction = try transactionService.fetchTransaction(id: transactionId)
            self.transaction = transaction
            delegate?.transactionDetailsViewModel(self, didChangeState: .content(makeContent(from: transaction)))
        } catch {
            delegate?.transactionDetailsViewModel(self, didChangeState: .error("Failed to load transaction"))
        }
    }

    private func makeContent(from transaction: Transaction) -> TransactionDetailsContentViewModel {
        TransactionDetailsContentViewModel(
            title: transaction.title,
            amount: transaction.amount.formattedCurrency(),
            type: transaction.type.rawValue,
            category: transaction.category,
            paymentMethod: transaction.paymentMethod.rawValue,
            date: transaction.date.formattedMediumDate(),
            description: transaction.description
        )
    }
}
