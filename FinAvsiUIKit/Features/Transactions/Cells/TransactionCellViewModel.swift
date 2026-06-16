//
//  TransactionCellViewModel.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

struct TransactionCellViewModel {
    let title: String
    let category: String
    let amount: String
    let date: String
    let type: TransactionType

    init(transaction: Transaction) {
        self.title = transaction.title
        self.category = transaction.category
        self.type = transaction.type
        self.amount = transaction.amount.formattedCurrency()
        self.date = transaction.date.formattedMediumDate()
    }
}
