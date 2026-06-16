//
//  DashboardRouter.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

protocol DashboardRouting: AnyObject {
    func showTransactions()
    func showTransactionDetails(_ transaction: Transaction)
}

final class DashboardRouter: BaseRouter, DashboardRouting {
    func showTransactions() {
        container.mainTabRouter?.showTransactions()
    }

    func showTransactionDetails(_ transaction: Transaction) {
        push(TransactionDetailsRoute(transactionId: transaction.id))
    }
}
