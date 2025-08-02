//
//  CoinImageViewModel.swift
//  Coiny
//
//  Created by Mohamed Atallah on 02/08/2025.
//

import Foundation
import SwiftUI
import Combine


final class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let coin: Coin
    private let dataService: CoinImageService
    
    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)

    }
}
