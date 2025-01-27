//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/20/25.
//

import Foundation

struct Coin : Codable , Identifiable {
    
    let id, symbol, name , image: String
        let currentPrice: Double
        let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
        let high24H, low24H: Double?
        let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
        let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
        let athChangePercentage: Double?
        let athDate: String?
        let atl, atlChangePercentage: Double?
        let atlDate: String?
        let lastUpdated: String?
        let sparklineIn7D: SparklineIn7D?
        let priceChangePercentage24HInCurrency: Double?
        let currentHoldings : Double?


    
  
    

    var currentHoldingsValue : Double {
        ( currentHoldings ?? 0 ) * currentPrice
    }
}
struct SparklineIn7D : Codable {
    let price : [Double]?
}



