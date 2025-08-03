//
//  MarketData.swift
//  Coiny
//
//  Created by Mohamed Atallah on 03/08/2025.
//

import Foundation

// JSON Data
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
     "data": {
         "active_cryptocurrencies": 17892,
         "upcoming_icos": 0,
         "ongoing_icos": 49,
         "ended_icos": 3376,
         "markets": 1332,
         "total_market_cap": {
             "btc": 33013683.238674257,
             "eth": 1085008884.2978687,
             "ltc": 34361772251.36575,
             "bch": 6954132764.310622,
             "bnb": 5031173703.287267,
             "eos": 7566724129125.658,
             "xrp": 1298101702268.9026,
         },
         "total_volume": {
             "btc": 985439.0763072107,
             "eth": 32386878.64658102,
             "ltc": 1025678742.4432923,
             "bch": 207576783.1852246,
             "bnb": 150177583.36944744,
         },
         "market_cap_percentage": {
             "btc": 60.281886320052976,
             "eth": 11.131916323607824,
             "xrp": 4.567832410215825,
             "usdt": 4.363005305672873,
         },
         "market_cap_change_percentage_24h_usd": -3.4753141259223392,
         "updated_at": 1754235016
     }
 }
 */

// MARK: - MarketData
struct GlobalData: Codable {
    let data: MarketData?
}

// MARK: - DataClass
struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentageString()
        }
        return ""
    }
}
