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
            prices.map{
                let date = Date(timeIntervalSince1970: $0[0]/1000)
//                let formatter  =  DateFormatter()
//                formatter.dateFormat = "MM/dd/yy"
//                let formattedDate =  formatter.string(from: date)
            
                return DailyCoinData(price: $0[1], date: date )}
        }
    }
  
    
}

struct DailyCoinData : Identifiable{
    let id = UUID()
    
    var price : Double
    
    var date : Date
}


