//
//  TransactionServiceProtocol.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

protocol TransactionServiceProtocol {
    func fetchTransactions() throws -> [Transaction]
    func fetchTransactions(filter: TransactionFilter) throws -> [Transaction]
    func fetchTransaction(id: UUID) throws -> Transaction
    func createTransaction(_ transaction: Transaction) throws
    func updateTransaction(_ transaction: Transaction) throws
    func deleteTransaction(id: UUID) throws
}
