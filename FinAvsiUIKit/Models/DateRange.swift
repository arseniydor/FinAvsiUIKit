//
//  DateRange.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

struct DateRange {
    let startDate: Date
    let endDate: Date
}

extension DateRange {
    static func month(containing date: Date, calendar: Calendar = .current) -> DateRange {
        let components = calendar.dateComponents([.year, .month], from: date)
        let startDate = calendar.date(from: components) ?? date
        let endDate = calendar.date(byAdding: DateComponents(month: 1, second: -1), to: startDate) ?? date
        return DateRange(startDate: startDate, endDate: endDate)
    }
}
