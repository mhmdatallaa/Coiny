//
//  Double.swift
//  Coiny
//
//  Created by Mohamed Atallah on 01/08/2025.
//

import Foundation

extension Double {
    /// Converts a Double into a Currency with 2-6 decimal places
    ///``` Exambles
    /// Convert 1234.56  to $1,234.56
    /// Convert 12.3456  to $12.3456
    /// Convert 0.123456 to $0.123456
    ///```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 6
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double into a Currency as String with 2-6 decimal places
    ///``` Exambles
    /// Convert 1234.56  to "$1,234.56"
    /// Convert 12.3456  to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    ///```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into string representation
    ///``` Exambles
    /// Convert 1.23456  to "1.23"
    ///```
    func asNumberString() -> String {
        String(format: "%.2f", self)
    }
    
    func asPercentageString() -> String {
        asNumberString() + "%"
    }
}
