//
//  DetailViewModel.swift
//  Coiny
//
//  Created by Mohamed Atallah on 06/08/2025.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published var coinDescrtption: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    @Published var coin: Coin
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self]  returnedValue in
                self?.overviewStatistics = returnedValue.overview
                self?.additionalStatistics = returnedValue.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescrtption = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetails: CoinDetail?, coin: Coin) -> (overview: [Statistic], additional: [Statistic]){
        let overviewArray = createOverviewArray(coin: coin)
        let additionalArray = createAddtionalArray(coinDetails: coinDetails, coin: coin)
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic] {
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations () ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)
        
        return [ priceStat, marketCapStat, rankStat, volumeStat ]
        
    }
    private func createAddtionalArray(coinDetails: CoinDetail?, coin: Coin) -> [Statistic] {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange:
        marketCapPercentChange2)
        
        let blockTime = coinDetails?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetails?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        
        return [ highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat ]
        
        
    }
}
