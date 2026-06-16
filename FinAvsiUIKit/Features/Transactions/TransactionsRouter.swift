//
//  TransactionsRouter.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

protocol TransactionsRouting: AnyObject {
    func showAddTransaction()
    func showTransactionDetails(_ transaction: Transaction)
}

final class TransactionsRouter: BaseRouter, TransactionsRouting {
    func showAddTransaction() {
        push(AddTransactionRoute())
    }

    func showTransactionDetails(_ transaction: Transaction) {
        push(TransactionDetailsRoute(transactionId: transaction.id))
    }
}
