//
//  AnalyticService.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

final class AnalyticsService: AnalyticsServiceProtocol {
    private let transactionService: TransactionServiceProtocol

    init(transactionService: TransactionServiceProtocol) {
        self.transactionService = transactionService
    }

    func buildAnalytics(dateRange: DateRange) throws -> DashboardAnalytics {
        let filter = TransactionFilter(startDate: dateRange.startDate, endDate: dateRange.endDate)
        let transactions = try transactionService.fetchTransactions(filter: filter)
        return makeAnalytics(from: transactions)
    }
}

private extension AnalyticsService {
    func makeAnalytics(from transactions: [Transaction]) -> DashboardAnalytics {
        let incomeTransactions = transactions.filter {
            $0.type == .income
        }

        let expenseTransactions = transactions.filter {
            $0.type == .expense
        }

        let totalIncome = incomeTransactions.reduce(0) {
            $0 + $1.amount
        }

        let totalExpenses = expenseTransactions.reduce(0) {
            $0 + $1.amount
        }

        let averageExpense = expenseTransactions.isEmpty ? 0 : (totalExpenses / Double(expenseTransactions.count))

        let categoryAnalytics = makeCategoryAnalytics(from: expenseTransactions)

        return DashboardAnalytics(
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
            balance: totalIncome - totalExpenses,
            transactionCount: transactions.count,
            averageExpense: averageExpense,
            topCategory: categoryAnalytics.first,
            categoryAnalytics: categoryAnalytics
        )
    }

    func makeCategoryAnalytics(from transactions: [Transaction]) -> [CategoryAnalytics] {
        let groupedTransactions = Dictionary(grouping: transactions, by: { $0.category })

        return groupedTransactions
            .map { category, transactions in
                CategoryAnalytics(
                    category: category,
                    amount: transactions.reduce(0) {
                        $0 + $1.amount
                    },
                    transactionCount: transactions.count
                )
            }
            .sorted {
                $0.amount > $1.amount
            }
    }
}
