//
//  CoinRowView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 01/08/2025.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingCoulmn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftCoulmn
            Spacer()
            if showHoldingCoulmn {
                centerCoulmn
            }
            rightCoulmn
        }
        .font(.subheadline)
        // make all row clickable
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
        CoinRowView(coin: Coin.sambleData, showHoldingCoulmn: true)
}

extension CoinRowView {
    private var leftCoulmn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerCoulmn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightCoulmn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :
                    Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
