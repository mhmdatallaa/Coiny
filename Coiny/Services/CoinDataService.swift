//
//  CoinDataService.swift
//  Coiny
//
//  Created by Mohamed Atallah on 02/08/2025.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allcoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allcoins = returnedCoins
                Logger.shared.log("\(returnedCoins.count) coins", level: .info)
                self?.coinSubscription?.cancel()
            })
    }
}
