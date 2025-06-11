//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/20/25.
//

import Foundation
import SwiftData

 struct Coin : Codable , Identifiable {
    
        var id, symbol, name , image: String
        var currentPrice: Double
        var marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
        var high24H, low24H: Double?
        var priceChange24H, priceChangePercentage24H: Double?
        var marketCapChange24H: Double?
        var marketCapChangePercentage24H: Double?
        var circulatingSupply, totalSupply, maxSupply, ath: Double?
        var athChangePercentage: Double?
        var athDate: String?
        var atl, atlChangePercentage: Double?
        var atlDate: String?
        var lastUpdated: String?
        var sparklineIn7D: SparklineIn7D?
        var priceChangePercentage24HInCurrency: Double?
        var currentHoldings : Double?
    
  

        var currentHoldingsValue : Double {
            (currentHoldings ?? 0.0) * currentPrice
        }
     
  
     mutating func updateHoldins(to:Double){
         currentHoldings = to
     }
}
struct SparklineIn7D : Codable {
    let price : [Double]?
}




