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
    @Published var isLoading: Bool = false
    
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
        
        // Updates Portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCointToPortfolioCoins)
            .sink { [weak self] coins in
                self?.protfolioCoins = coins
            }
            .store(in: &cancellabels)
        
        // Updates marketData
        marketDataService.$markedData
            .combineLatest($protfolioCoins)
            .map(mapGloblaMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
                self?.isLoading = false
            }
            .store(in: &cancellabels)
        
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
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
    
    private func mapAllCointToPortfolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
        allCoins.compactMap { coin in
            guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGloblaMarketData(data: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data  else { return stats}
        
        let marketCap = Statistic(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Vloume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins.map { $0.currentHoldingsValue }.reduce(0, +)
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0.0) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }.reduce (0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let protfolio = Statistic(title: "Portfolio", value: portfolioValue.asCurrencyWith6Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, protfolio])
        
        return stats
        
    }
    
}
