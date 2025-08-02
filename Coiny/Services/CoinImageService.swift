//
//  CoinImageService.swift
//  Coiny
//
//  Created by Mohamed Atallah on 02/08/2025.
//

import Foundation
import SwiftUI
import Combine

final class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private let coin: Coin
    private var imageSubscription: AnyCancellable?
    
    init(coin: Coin) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
