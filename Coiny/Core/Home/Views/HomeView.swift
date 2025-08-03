//
//  HomeView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 31/07/2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showProtfolio = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                HomeStatsView(showProtfolio: $showProtfolio)
                SearchBarView(searchText: $vm.searchText)
                columnsTitles
                
                if !showProtfolio {
                    allCoinsList
                        // cell animation move to left
                        .transition(.move(edge: .leading))
                }
                
                if showProtfolio {
                    protfoliocoinsList
                        // cell animation move to right
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
}

extension HomeView {
    
    // MARK: - homeHeader
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showProtfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showProtfolio)
                    )
            Spacer()
            Text(showProtfolio ? "Protfolio" : "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProtfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showProtfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    // MARK: - allCoinsList
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingCoulmn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    // MARK: - protfoliocoinsList
    private var protfoliocoinsList: some View {
        List {
            ForEach(vm.protfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingCoulmn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    // MARK: - columnsTitles
    private var columnsTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showProtfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
