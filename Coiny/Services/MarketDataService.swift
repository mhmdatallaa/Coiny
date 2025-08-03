//
//  MarketDataService.swift
//  Coiny
//
//  Created by Mohamed Atallah on 03/08/2025.
//

import Foundation
import Combine

final class MarketDataService {
    @Published var markedData: MarketData? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.markedData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
    
}
