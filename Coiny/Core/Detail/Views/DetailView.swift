//
//  DetalView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 05/08/2025.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: Coin?

    var body: some View {
        ZStack {
            if let coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        Logger.shared.log("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        Text("coin.name ")
    }
    
}

#Preview {
    DetailView(coin: Coin.sambleData)
}
