//
//  HistoricCoinDataModel.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 3/23/25.
//

import Foundation


struct HistoricCoinDataModel: Codable{
    
    let prices, marketCaps, totalVolumes: [[Double]]
    
    var chartDataPoints: [DailyCoinData] {
        get{
            prices.map{DailyCoinData(price: $0[1], date: Date(timeIntervalSince1970: $0[0]/1000))}
        }
    }
}

struct DailyCoinData : Identifiable{
    let id = UUID()
    
    var price : Double
    
    var date : Date
}


