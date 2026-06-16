//
//  TransactionDetailsRouter.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

protocol TransactionDetailsRouting: AnyObject {
    func showEditTransaction(_ transaction: Transaction)
    func close()
}

final class TransactionDetailsRouter: BaseRouter, TransactionDetailsRouting {
    func showEditTransaction(_ transaction: Transaction) {
        push(EditTransactionRoute(transaction: transaction))
    }

    func close() {
        pop()
    }
}
