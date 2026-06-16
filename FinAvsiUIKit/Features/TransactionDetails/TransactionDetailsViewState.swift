//
//  TransactionDetailsViewState.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

enum TransactionDetailsViewState {
    case content(TransactionDetailsContentViewModel)
    case error(String)
}

struct TransactionDetailsContentViewModel {
    let title: String
    let amount: String
    let type: String
    let category: String
    let paymentMethod: String
    let date: String
    let description: String?
}
