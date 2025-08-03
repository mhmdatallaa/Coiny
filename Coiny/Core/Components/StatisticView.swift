//
//  StatisticView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 03/08/2025.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic: Statistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(statistic.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:(statistic.percentagechange ?? 0) >= 0 ? 0 : 180))
                Text(statistic.percentagechange?.asPercentageString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(
                (statistic.percentagechange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(statistic.percentagechange == nil ? 0.0 : 1.0)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(statistic: Statistic.sambleStatistic1)
        .padding()
}

