//
//  HomeViewModel.swift
//  Coiny
//
//  Created by Mohamed Atallah on 02/08/2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = []
    
    @Published var allCoins: [Coin] = []
    @Published var protfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        // Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allcoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellabels)
        
        // Updates marketData
        marketDataService.$markedData
            .map(mapGloblaMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellabels)
        
        // Updates Portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coins, portfolioEntities) -> [Coin] in
                coins.compactMap { coin in
                    guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                        return nil
                    }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] coins in
                self?.protfolioCoins = coins
            }
            .store(in: &cancellabels)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    private func mapGloblaMarketData(data: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data  else { return stats}
        
        let marketCap = Statistic(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Vloume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let protfolio = Statistic(title: "Portfolio", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, protfolio])
        
        return stats

    }
    
}
