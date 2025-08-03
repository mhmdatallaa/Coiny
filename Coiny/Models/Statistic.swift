//
//  Statistic.swift
//  Coiny
//
//  Created by Mohamed Atallah on 03/08/2025.
//

import Foundation

struct Statistic: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

extension Statistic {
    static let sambleStatistic1 = Statistic(title: "Market Cap", value: "$12.58n", percentageChange: 25.34)
    static let sambleStatistic2 = Statistic(title: "Total Volume", value: "$1.23Tr")
    static let sambleStatistic3 = Statistic(title: "Protfolio Value", value: "$3.341,23Tr", percentageChange: -12.3)
}
