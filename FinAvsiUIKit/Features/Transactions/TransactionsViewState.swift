//
//  TransactionsViewState.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

enum TransactionsSection {
    case main
}

enum TransactionsRow {
    case transaction(TransactionCellViewModel)
}

struct TransactionsSectionViewModel {
    let section: TransactionsSection
    let rows: [TransactionsRow]
}

enum TransactionsViewState {
    case loading
    case empty
    case content([TransactionsSectionViewModel])
    case error(String)
}
