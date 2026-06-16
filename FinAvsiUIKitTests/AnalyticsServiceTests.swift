//
//  AnalyticsServiceTests.swift
//  FinAvsiUIKitTests
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation
@testable import FinAvsiUIKit
import XCTest

final class AnalyticsServiceTests: XCTestCase {

    private var container: AppContainer!
    private var transactionService: TransactionServiceProtocol!
    private var analyticsService: AnalyticsServiceProtocol!

    override func setUp() {
        super.setUp()

        container = TestFactory.makeContainer()
        transactionService = container.transactionService
        analyticsService = container.analyticsService
    }

    override func tearDown() {
        container = nil
        transactionService = nil
        analyticsService = nil

        super.tearDown()
    }

    func testBuildAnalyticsCalculatesIncomeExpensesAndBalance() throws {
        try transactionService.createTransaction(
            makeTransaction(amount: 1000, type: .income, category: "Work")
        )

        try transactionService.createTransaction(
            makeTransaction(amount: 250, type: .expense, category: "Food")
        )

        let analytics = try analyticsService.buildAnalytics(
            dateRange: DateRange.month(containing: Date())
        )

        XCTAssertEqual(analytics.totalIncome, 1000)
        XCTAssertEqual(analytics.totalExpenses, 250)
        XCTAssertEqual(analytics.balance, 750)
        XCTAssertEqual(analytics.transactionCount, 2)
    }

    func testBuildAnalyticsCalculatesAverageExpense() throws {
        try transactionService.createTransaction(
            makeTransaction(amount: 100, type: .expense, category: "Food")
        )

        try transactionService.createTransaction(
            makeTransaction(amount: 300, type: .expense, category: "Transport")
        )

        let analytics = try analyticsService.buildAnalytics(
            dateRange: DateRange.month(containing: Date())
        )

        XCTAssertEqual(analytics.averageExpense, 200)
    }

    func testBuildAnalyticsCalculatesTopCategory() throws {
        try transactionService.createTransaction(
            makeTransaction(amount: 100, type: .expense, category: "Food")
        )

        try transactionService.createTransaction(
            makeTransaction(amount: 300, type: .expense, category: "Transport")
        )

        let analytics = try analyticsService.buildAnalytics(
            dateRange: DateRange.month(containing: Date())
        )

        XCTAssertEqual(analytics.topCategory?.category, "Transport")
        XCTAssertEqual(analytics.topCategory?.amount, 300)
    }

    private func makeTransaction(
        amount: Double,
        type: TransactionType,
        category: String,
        date: Date = Date()
    ) -> Transaction {
        Transaction(
            id: UUID(),
            amount: amount,
            type: type,
            category: category,
            title: category,
            description: nil,
            paymentMethod: .cash,
            date: date,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}
