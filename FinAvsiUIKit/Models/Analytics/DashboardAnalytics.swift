//
//  DashboardAnalytics.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

struct DashboardAnalytics {
    let totalIncome: Double
    let totalExpenses: Double
    let balance: Double
    let transactionCount: Int
    let averageExpense: Double
    let topCategory: CategoryAnalytics?
    let categoryAnalytics: [CategoryAnalytics]
}
