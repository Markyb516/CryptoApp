//
//  HomeVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/26/25.
//

import SwiftUI

import SwiftData

enum PortfolioError : LocalizedError{
    case portfolioNotFound
    var errorDescription: String?{
        switch self {
        case .portfolioNotFound :
            return "portfolio not found"
        }
    }
}

@Observable class HomeVM {
    var swiftDataManager : SwiftDataManager
    var allcoins:[Coin]?
    var foundCoins:[Coin]?
    var marketStats:MarketDataModel?
    private var filterTask: Task<Void,Never>? = nil
    var activeCoinToEdit : Coin?
    var portfolioCoins: [Coin]?
    var sortIndicatorLocation : arrowLocation?
    var selectedDetailedCoin:DetailedCoinDataModel?
    
    
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
                    
                    allcoins = filteredCoins
                }
            }
        }
    }
    
    @MainActor func getCoinDetails(id:String) async {
        Task{
            if let coinData = await CoinService.retrieveCoinData(id: id){
                selectedDetailedCoin = coinData
                print(coinData.marketData)
                 
            }
        }
    }
    
    
    init(swiftDataManager : SwiftDataManager) {
        self.swiftDataManager  = swiftDataManager
        
        
        
        Task{
            
         
            if let marketData = await CoinService.retrieveStats(){
                if let coins = await getCoins(){
                    foundCoins = coins
                    await  MainActor.run {
                        allcoins = coins
                        marketStats = marketData
                        portfolioCoins = getPortfolioCoins()
                        self.swiftDataManager.addExamples()
                    }
                }
            }
        }
    }
    
    
    
    private func getDatabaseLocation(){
        
        let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
        
        let url = urlApp!.appendingPathComponent("default.store")
        
        if FileManager.default.fileExists(atPath: url.path) {
                  print("swiftdata db at \(url.absoluteString)")
            }
    }
     
    
    func getCoins() async -> [Coin]? {
        do{
            return try await CoinService.retrieveCoins()
        }
        catch{
            print(error)
            return nil
        }
    }
    
    
    
    @MainActor func sortByName(portfolio : Bool, ascending : Bool = true){
        sortIndicatorLocation = .symbol
        if let coins = allcoins , !portfolio{
            if ascending{
                var mutableCoins = coins
                mutableCoins.sort { $0.symbol < $1.symbol }
                allcoins = mutableCoins
            }else{
                var mutableCoins = coins
                mutableCoins.sort { $0.symbol > $1.symbol }
                allcoins = mutableCoins
            }
        }
        else{
            if let coins = portfolioCoins{
                if ascending{
                    var mutableCoins = coins
                    mutableCoins.sort { $0.symbol < $1.symbol }
                    portfolioCoins = mutableCoins
                }else{
                    var mutableCoins = coins
                    mutableCoins.sort{ $0.symbol > $1.symbol }
                    portfolioCoins = mutableCoins
                }
            }
        }
    }
    
    
    @MainActor func sortByPrice(portfolio : Bool, ascending : Bool = true){
        sortIndicatorLocation = .price

        if let coins = allcoins , !portfolio{
            if ascending {
                var mutableCoins = coins
                mutableCoins.sort { $0.currentPrice < $1.currentPrice }
                allcoins = mutableCoins
            }
            else{
                var mutableCoins = coins
                mutableCoins.sort { $0.currentPrice > $1.currentPrice }
                allcoins = mutableCoins
            }
        }
        
        else{
            if let coins = portfolioCoins{
                if ascending{
                    var mutableCoins = coins
                    mutableCoins.sort { $0.currentPrice < $1.currentPrice }
                    portfolioCoins = mutableCoins
                }else{
                    var mutableCoins = coins
                    mutableCoins.sort { $0.currentPrice > $1.currentPrice }
                    portfolioCoins = mutableCoins
                }
            }
        }
    }
    
    
    
    @MainActor func sortByHoldings(ascending : Bool = true){
        sortIndicatorLocation = .holdings
        if let coins = portfolioCoins{
            if ascending{
                var mutableCoins = coins
                mutableCoins.sort { $0.currentHoldings ?? 0.0 < $1.currentHoldings ?? 0.0 }
                portfolioCoins = mutableCoins
            }
            else{
                var mutableCoins = coins
                mutableCoins.sort { $0.currentHoldings ?? 0.0 > $1.currentHoldings ?? 0.0  }
                portfolioCoins = mutableCoins
                
            }
            
        }
        
    }
    
    
    
    @MainActor func getPortfolioCoins() -> [Coin]? {
        let fetchedResult = swiftDataManager.fetchPortfolio()
        if let portfolio = fetchedResult.first, !fetchedResult.isEmpty , let coins = allcoins {
            
            var portfolioDict:[String:Double] = [:]
            
            portfolio.portfolioCoins.forEach { portfolioDict[$0.name] = $0.currentHoldings  }
            
            var  holder =  coins.filter{ coin in
                portfolioDict[coin.name] != nil ? true : false
            }
            
            holder = holder.map{ coin in
                var mutableCoin = coin
                mutableCoin.currentHoldings = portfolioDict[coin.name , default: 0.0]
                return mutableCoin
            }
            return holder
        }
        return nil
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @MainActor func updatePortfolioCoinHolding( by amt: Double ){
        if let activeCoinToEdit {
            print(self.swiftDataManager.editCoin(activeCoinToEdit, by:amt))
            
        }
    }
    
    
    
    
    enum  arrowLocation{
        case price
        case holdings
        case symbol
    }
    
    
    
}
   

    

