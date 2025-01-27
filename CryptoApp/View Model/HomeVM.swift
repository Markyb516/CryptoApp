//
//  HomeVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/26/25.
//

import Foundation

@Observable class HomeVM {
    var allcoins:[Coin]?
    var portfolioCoins:[Coin]? {
        if let coins = allcoins{
            return coins.filter{$0.currentHoldings ?? -1 > 0 ? true : false}
        }
      return nil
    }
    
    init() {
        Task{
            if let coins = await getCoins(){
               await  MainActor.run {
                    allcoins = coins
                }
            }
        }
    }
    
    private func getCoins() async  -> [Coin]? {
    
            do{
                return try await CoinService.instance.retrieveCoins()
            }
            catch{
                print(error)
                return nil
               
            }
        
    }
    
    
}
