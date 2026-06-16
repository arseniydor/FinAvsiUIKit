//
//  AnalyticsServiceProtocol.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

protocol AnalyticsServiceProtocol {
    func buildAnalytics(dateRange: DateRange) throws -> DashboardAnalytics
}
