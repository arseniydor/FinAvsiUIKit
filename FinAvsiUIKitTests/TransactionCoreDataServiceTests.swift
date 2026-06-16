//
//  TransactionCoreDataServiceTests.swift
//  FinAvsiUIKitTests
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

@testable import FinAvsiUIKit
import XCTest

final class TransactionCoreDataServiceTests: XCTestCase {

    private var container: AppContainer!
    private var service: TransactionServiceProtocol!

    override func setUp() {
        super.setUp()

        container = TestFactory.makeContainer()
        service = container.transactionService
    }

    override func tearDown() {
        container = nil
        service = nil

        super.tearDown()
    }

    func testCreateAndFetchTransactions() throws {
        let transaction = makeTransaction(title: "Coffee")

        try service.createTransaction(transaction)

        let transactions = try service.fetchTransactions()

        XCTAssertEqual(transactions.count, 1)
        XCTAssertEqual(transactions.first?.title, "Coffee")
    }

    func testUpdateTransaction() throws {
        let transaction = makeTransaction(title: "Coffee")

        try service.createTransaction(transaction)

        let updated = Transaction(
            id: transaction.id,
            amount: 10,
            type: .expense,
            category: "Food",
            title: "Updated Coffee",
            description: nil,
            paymentMethod: .card,
            date: transaction.date,
            createdAt: transaction.createdAt,
            updatedAt: Date()
        )

        try service.updateTransaction(updated)

        let fetched = try service.fetchTransaction(id: transaction.id)

        XCTAssertEqual(fetched.title, "Updated Coffee")
        XCTAssertEqual(fetched.amount, 10)
        XCTAssertEqual(fetched.paymentMethod, .card)
    }

    func testDeleteTransaction() throws {
        let transaction = makeTransaction(title: "Coffee")

        try service.createTransaction(transaction)
        try service.deleteTransaction(id: transaction.id)

        let transactions = try service.fetchTransactions()

        XCTAssertTrue(transactions.isEmpty)
    }

    func testFetchTransactionsWithFilter() throws {
        try service.createTransaction(
            makeTransaction(title: "Coffee", amount: 5, category: "Food")
        )

        try service.createTransaction(
            makeTransaction(title: "Salary", amount: 1000, type: .income, category: "Work")
        )

        let filtered = try service.fetchTransactions(
            filter: TransactionFilter(
                type: .expense,
                searchText: "coffee"
            )
        )

        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.title, "Coffee")
    }

    private func makeTransaction(
        title: String,
        amount: Double = 5,
        type: TransactionType = .expense,
        category: String = "Food"
    ) -> Transaction {
        Transaction(
            id: UUID(),
            amount: amount,
            type: type,
            category: category,
            title: title,
            description: nil,
            paymentMethod: .cash,
            date: Date(),
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}
