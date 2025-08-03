//
//  HomeStatsView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 03/08/2025.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Binding var showProtfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(homeViewModel.statistics) { stat in
                StatisticView(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width/3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showProtfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showProtfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
