//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 2/3/25.
//

import Foundation

struct MarketDataModel: Codable{
    
    var btcMarketDominance:Double{
        data.marketCapPercentage["btc", default: 0]
    }
    
    let data: cryptoDate
    
    var marketCap:Double{
        var total:Double = 0
        for currencyMarketCap in data.totalMarketCap.values{
            total += currencyMarketCap
        }
        return total
    }
    
    var marketVolume:Double {
        var total:Double = 0
        for currencyMarketCap in data.totalVolume.values{
            total += currencyMarketCap
        }
        return total
    }
    
    var marketPecentageChange:Double{
        data.marketCapChangePercentage24HUsd
    }
    
   
    
    
    struct cryptoDate:Codable{
            let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
            let marketCapChangePercentage24HUsd: Double
    }
}
