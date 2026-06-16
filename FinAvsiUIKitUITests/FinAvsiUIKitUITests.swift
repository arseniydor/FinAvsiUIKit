//
//  FinAvsiUIKitUITests.swift
//  FinAvsiUIKitUITests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import XCTest

final class FinAvsiUIKitUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launch()
    }

    override func tearDown() {
        app = nil

        super.tearDown()
    }

    func testAppLaunches() {
        XCTAssertTrue(app.tabBars.firstMatch.exists)
        XCTAssertTrue(app.tabBars.buttons["Dashboard"].exists)
        XCTAssertTrue(app.tabBars.buttons["Transactions"].exists)
    }

    func testAddTransactionAppearsInTransactionsList() {
        openTransactionsTab()
        addTransaction(
            title: "Coffee",
            amount: "4.50",
            category: "Food"
        )

        XCTAssertTrue(
            app.staticTexts["Coffee"].waitForExistence(timeout: 3)
        )

        XCTAssertTrue(
            app.staticTexts["Food"].exists
        )
    }

    func testSearchTransaction() {
        openTransactionsTab()

        addTransaction(
            title: "Coffee",
            amount: "4.50",
            category: "Food"
        )

        addTransaction(
            title: "Salary",
            amount: "2500",
            category: "Work",
            typeIndex: 0
        )

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 3))

        searchField.tap()
        searchField.typeText("Coffee")

        XCTAssertTrue(app.staticTexts["Coffee"].exists)
        XCTAssertFalse(app.staticTexts["Salary"].exists)
    }

    func testOpenTransactionDetails() {
        openTransactionsTab()

        addTransaction(
            title: "Coffee",
            amount: "4.50",
            category: "Food"
        )

        app.staticTexts["Coffee"].tap()

        XCTAssertTrue(
            app.navigationBars["Transaction"].waitForExistence(timeout: 3)
        )

        let categoryLabel = app.staticTexts["transactionDetails.categoryLabel"]

        XCTAssertTrue(categoryLabel.waitForExistence(timeout: 3))
        XCTAssertEqual(categoryLabel.label, "Category: Food")
    }
    
    func testEditTransaction() {
        openTransactionsTab()

        addTransaction(
            title: "Coffee",
            amount: "4.50",
            category: "Food"
        )

        app.staticTexts["Coffee"].tap()
        app.buttons["transactionDetails.editButton"].tap()

        let titleField = app.textFields["editTransaction.titleTextField"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 3))

        titleField.tap()
        titleField.buttons["Clear text"].tap()
        titleField.typeText("Updated Coffee")

        app.buttons["editTransaction.saveButton"].tap()

        let titleLabel = app.staticTexts["transactionDetails.titleLabel"]

        XCTAssertTrue(titleLabel.waitForExistence(timeout: 3))
        XCTAssertEqual(titleLabel.label, "Updated Coffee")
    }
}
private extension FinAvsiUIKitUITests {

    func openTransactionsTab() {
        app.tabBars.buttons["Transactions"].tap()
    }

    func addTransaction(
        title: String,
        amount: String,
        category: String,
        typeIndex: Int = 1,
        paymentMethodIndex: Int = 0
    ) {
        app.buttons["transactions.addButton"].tap()

        let titleField = app.textFields["addTransaction.titleTextField"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 3))
        titleField.tap()
        titleField.typeText(title)

        let amountField = app.textFields["addTransaction.amountTextField"]
        amountField.tap()
        amountField.typeText(amount)

        let categoryField = app.textFields["addTransaction.categoryTextField"]
        categoryField.tap()
        categoryField.typeText(category)

        let typeControl = app.segmentedControls["addTransaction.typeSegmentedControl"]
        XCTAssertTrue(typeControl.exists)

        typeControl.buttons.element(boundBy: typeIndex).tap()

        let paymentControl = app.segmentedControls["addTransaction.paymentMethodSegmentedControl"]
        XCTAssertTrue(paymentControl.exists)

        paymentControl.buttons.element(boundBy: paymentMethodIndex).tap()

        app.buttons["addTransaction.saveButton"].tap()
    }
}
