//
//  CoinDetailsVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 4/6/25.
//

import Foundation

@Observable class CoinDetailsVM{
    
    var selectedDetailedCoin:DetailedCoinDataModel?
    @MainActor var selectedDetailedCoinChartData: [DailyCoinData]?
    
    init(id:String){
        Task{
            await getCoinDetails(id: id)
        }
    }
    
    @MainActor func getCoinDetails(id:String) async {
        Task{ [weak self] in
            if let coinData = await CoinService.retrieveCoinData(id: id),
               let result = await CoinService.retieveCoinHistory(id: id) {
                
                self?.selectedDetailedCoin = coinData
                self?.selectedDetailedCoinChartData = result.chartDataPoints
            }
        }
    }
    
    
    
    
    
}

