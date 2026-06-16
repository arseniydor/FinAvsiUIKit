//
//  DashboardViewModel.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

protocol DashboardViewModelDelegate: AnyObject {
    func dashboardViewModel(_ viewModel: DashboardViewModel, didChangeState state: DashboardViewState)
}

final class DashboardViewModel {
    weak var delegate: DashboardViewModelDelegate?

    private let router: DashboardRouting
    private let analyticsService: AnalyticsServiceProtocol

    private var selectedMonth = Date()

    init(router: DashboardRouting, analyticsService: AnalyticsServiceProtocol) {
        self.router = router
        self.analyticsService = analyticsService
    }

    func viewDidLoad() {
        loadDashboard()
    }

    func viewWillAppear() {
        loadDashboard()
    }

    func previousMonthTapped() {
        selectedMonth = Calendar.current.date(
            byAdding: .month,
            value: -1,
            to: selectedMonth
        ) ?? selectedMonth

        loadDashboard()
    }

    func nextMonthTapped() {
        selectedMonth = Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: selectedMonth
        ) ?? selectedMonth

        loadDashboard()
    }

    func transactionsTapped() {
        router.showTransactions()
    }

    private func loadDashboard() {
        delegate?.dashboardViewModel(self, didChangeState: .loading)

        do {
            let dateRange = DateRange.month(containing: selectedMonth)
            let analytics = try analyticsService.buildAnalytics(dateRange: dateRange)
            let sections = makeSections(from: analytics)
            delegate?.dashboardViewModel(self, didChangeState: .content(sections))
        } catch {
            delegate?.dashboardViewModel(self, didChangeState: .error("Failed to load dashboard"))
        }
    }

    private func makeSections(from analytics: DashboardAnalytics) -> [DashboardSectionViewModel] {
        var dataSource: [DashboardSectionViewModel] = []

        let categories = analytics.categoryAnalytics.map {
            CategoryAnalyticsViewModel(
                category: $0.category,
                amountText: $0.amount.formattedCurrency(),
                transactionCountText: "\($0.transactionCount)"
            )
        }

        let monthSection: DashboardSection = .month
        let monthRows: [DashboardRow] = [.month(selectedMonth.formattedMonthTitle())]
        let monthViewModel = DashboardSectionViewModel(section: monthSection, rows: monthRows)

        dataSource.append(monthViewModel)

        let summarySection: DashboardSection = .summary
        let summaryRows: [DashboardRow] = [
            .summary(title: "Balance", value: analytics.balance.formattedCurrency()),
            .summary(title: "Income", value: analytics.totalIncome.formattedCurrency()),
            .summary(title: "Expenses", value: analytics.totalExpenses.formattedCurrency()),
            .summary(title: "Transactions", value: "\(analytics.transactionCount)"),
            .summary(title: "Average Expense", value: analytics.averageExpense.formattedCurrency()),
            .summary(title: "Top Category", value: analytics.topCategory?.category ?? "—"),
        ]
        let summaryViewModel = DashboardSectionViewModel(section: summarySection, rows: summaryRows)

        dataSource.append(summaryViewModel)

        let categoriesSection: DashboardSection = .categories
        let categoriesRows: [DashboardRow] = categories.isEmpty ? [.emptyCategories] : categories.map { .category($0) }
        let categoriesViewModel = DashboardSectionViewModel(section: categoriesSection, rows: categoriesRows)

        dataSource.append(categoriesViewModel)

        let actionSection: DashboardSection = .actions
        let actionRows: [DashboardRow] = [.transactionsButton]
        let actionViewModel = DashboardSectionViewModel(section: actionSection, rows: actionRows)

        dataSource.append(actionViewModel)

        return dataSource
    }
}
