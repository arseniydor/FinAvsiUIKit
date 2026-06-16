//
//  Double+Currency.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

extension Double {
    func formattedCurrency(currencyCode: String = "EUR") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode

        return formatter.string(from: NSNumber(value: self)) ?? "\(currencyCode) 0.00"
    }
}
