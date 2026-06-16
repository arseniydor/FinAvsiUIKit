//
//  DashboardViewState.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

enum DashboardSection {
    case month
    case summary
    case categories
    case actions
}

enum DashboardRow {
    case month(String)
    case summary(title: String, value: String)
    case category(CategoryAnalyticsViewModel)
    case emptyCategories
    case transactionsButton
}

struct DashboardSectionViewModel {
    let section: DashboardSection
    let rows: [DashboardRow]
}

enum DashboardViewState {
    case loading
    case content([DashboardSectionViewModel])
    case error(String)
}

struct CategoryAnalyticsViewModel: Hashable {
    let category: String
    let amountText: String
    let transactionCountText: String
}
