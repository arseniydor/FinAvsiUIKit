//
//  TransactionsViewModel.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation
import UIKit

protocol TransactionsViewModelDelegate: AnyObject {
    func transactionsViewModel(_ viewModel: TransactionsViewModel, didChangeState state: TransactionsViewState)
}

final class TransactionsViewModel {
    weak var delegate: TransactionsViewModelDelegate?

    private let router: TransactionsRouting

    private var transactions: [Transaction] = []
    private var filteredTransactions: [Transaction] = []
    private let transactionService: TransactionServiceProtocol
        
    init(router: TransactionsRouting, transactionService: TransactionServiceProtocol) {
        self.router = router
        self.transactionService = transactionService
    }

    func viewDidLoad() {
        loadTransactions()
    }

    func viewWillAppear() {
        loadTransactions()
    }

    func addButtonTapped() {
        router.showAddTransaction()
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard let transaction = transaction(at: indexPath) else {
            return
        }

        router.showTransactionDetails(transaction)
    }

    func searchTextDidChange(_ text: String?) {
        let query = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !query.isEmpty else {
            filteredTransactions = transactions
            render(filteredTransactions)
            return
        }

        filteredTransactions = transactions.filter {
            $0.title.localizedCaseInsensitiveContains(query)
                || $0.category.localizedCaseInsensitiveContains(query)
                || ($0.description?.localizedCaseInsensitiveContains(query) ?? false)
                || $0.type.rawValue.localizedCaseInsensitiveContains(query)
                || $0.paymentMethod.rawValue.localizedCaseInsensitiveContains(query)
        }

        render(filteredTransactions)
    }

    private func loadTransactions() {
        delegate?.transactionsViewModel(self, didChangeState: .loading)

        do {
            transactions = try transactionService.fetchTransactions()
            filteredTransactions = transactions

            render(filteredTransactions)
        } catch {
            delegate?.transactionsViewModel(self, didChangeState: .error("Failed to load transactions"))
        }
    }

    private func render(_ transactions: [Transaction]) {
        guard !transactions.isEmpty else {
            delegate?.transactionsViewModel(self, didChangeState: .empty)
            return
        }

        let rows: [TransactionsRow] = transactions.map { transaction in
            .transaction(TransactionCellViewModel(transaction: transaction))
        }

        let section = TransactionsSectionViewModel(section: .main, rows: rows)

        delegate?.transactionsViewModel(self, didChangeState: .content([section]))
    }

    private func transaction(at indexPath: IndexPath) -> Transaction? {
        guard filteredTransactions.indices.contains(indexPath.row) else {
            return nil
        }

        return filteredTransactions[indexPath.row]
    }
}
