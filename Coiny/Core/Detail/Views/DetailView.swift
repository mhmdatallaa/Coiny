//
//  DetalView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 05/08/2025.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: Coin?

    var body: some View {
        ZStack {
            if let coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private var spacing:CGFloat = 30
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        Logger.shared.log("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                overViewTitle
                Divider()
                overviewGird
                
                additionTitle
                Divider()
                additionalGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
    
}

#Preview {
    NavigationView {
        DetailView(coin: Coin.sambleData)
    }
}

extension DetailView {
    private var overViewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var overviewGird: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing) {
            ForEach(vm.overviewStatistics) { statistic in
                StatisticView(statistic: statistic)
            }
        }
    }
    
    private var additionTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing) {
            ForEach(vm.additionalStatistics) { statistic in
                StatisticView(statistic: statistic)
            }
        }

    }
    
}
