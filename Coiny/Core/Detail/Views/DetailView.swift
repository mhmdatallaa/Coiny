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
    @State private var showFullDescription: Bool = false
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
            ChartView(coin: vm.coin)
                .padding(.vertical)
            VStack {
                VStack(spacing: 20) {
                    overViewTitle
                    Divider()
                    descriptionSection
                    overviewGird
                    additionTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
//        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItem
            }
        }
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
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescrtption = vm.coinDescrtption, !coinDescrtption.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescrtption)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Read less.. " : "Read more..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
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
    private var navigationBarTrailingItem: some View {
        HStack {
            Text(vm.coin.symbol)
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteURL = vm.websiteURL,
               let url = URL(string: websiteURL) {
                Link("Website", destination: url)
            }
            
            if let redditURL = vm.redditURL,
               let url = URL(string: redditURL) {
                Link("Reddit", destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
    
}
