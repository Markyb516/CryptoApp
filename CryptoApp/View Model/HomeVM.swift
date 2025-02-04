//
//  HomeVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/26/25.
//

import Foundation

@Observable class HomeVM {
    var allcoins:[Coin]?
    var foundCoins:[Coin]?
    private var filterTask: Task<Void,Never>? = nil
        
    var filterText:String = ""{
        willSet{
            filterTask?.cancel()
            
            filterTask = Task {
                try? await Task.sleep(nanoseconds: 450_000_000) // 300ms delay

                if Task.isCancelled { return }

                let filteredCoins = if let coinsDisplayed = foundCoins, !newValue.isEmpty {
                    coinsDisplayed.filter {
                        $0.name.lowercased().contains(newValue.lowercased()) ||
                        $0.symbol.lowercased().contains(newValue.lowercased())
                    }
                } else {
                    foundCoins ?? nil
                }

                await MainActor.run {
                    print("ran")
                    allcoins = filteredCoins
                }
            }
        }
    }
    var portfolioCoins:[Coin]? {
        if let coins = allcoins{
            return coins.filter{$0.currentHoldings ?? -1 > 0 ? true : false}
        }
      return nil
    }
    
    init() {
        Task{
            if let coins = await getCoins(){
                foundCoins = coins
                await  MainActor.run {
                    allcoins = coins
                }
            }
        }
    }
    
    private func getCoins() async -> [Coin]? {
            do{
                return try await CoinService.retrieveCoins()
            }
            catch{
                print(error)
                return nil
            }
    }
    
}
