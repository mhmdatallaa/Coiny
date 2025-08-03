//
//  HomeViewModel.swift
//  Coiny
//
//  Created by Mohamed Atallah on 02/08/2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = [
        Statistic(title: "Title", value: "Value", percentageChange: 1),
        Statistic(title: "Title",value: "Value"),
        Statistic(title: "Title",value: "Value"),
        Statistic(title: "Title", value: "Value",percentageChange: -7)
    ]
    
    @Published var allCoins: [Coin] = []
    @Published var protfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDataService.$allcoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellabels)
        
        $searchText
            .combineLatest(coinDataService.$allcoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellabels)
    }
    
    private func filterCoins(searchText: String, coins: [Coin]) -> [Coin] {
        guard !searchText.isEmpty else { return coins }
        
        let lowercasedText = searchText.lowercased()
        let returnedCoins = coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText)   ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
        return returnedCoins
    }
    
}
