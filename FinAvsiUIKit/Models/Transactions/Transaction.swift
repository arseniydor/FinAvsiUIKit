//
//  Transaction.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    let id: UUID
    var amount: Double
    var type: TransactionType
    var category: String
    var title: String
    var description: String?
    var paymentMethod: PaymentMethod
    var date: Date
    var createdAt: Date
    var updatedAt: Date
}
