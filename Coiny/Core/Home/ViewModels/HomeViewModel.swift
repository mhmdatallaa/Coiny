//
//  HomeViewModel.swift
//  Coiny
//
//  Created by Mohamed Atallah on 02/08/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var protfolioCoins: [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(Coin.sambleData)
            self.protfolioCoins.append(Coin.sambleData)
        }
    }
}
