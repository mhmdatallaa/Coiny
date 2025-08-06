//
//  DetailViewModel.swift
//  Coiny
//
//  Created by Mohamed Atallah on 06/08/2025.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { coinDetails in
                Logger.shared.log("RECEVED COIN DETAILS: \(coinDetails)", level: .info)
            }
            .store(in: &cancellables)
    }
}
