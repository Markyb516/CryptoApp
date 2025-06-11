//
//  HomeVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/26/25.
//

import SwiftUI

import SwiftData


@Observable class HomeVM {
    private var filterTask: Task<Void,Never>? = nil
    var swiftDataManager : SwiftDataManager
    var allCoins:[Coin]?
    var filteredCoins:[Coin]?
    var portfolioFilteredCoins:[Coin]?
    var marketStats:MarketDataModel?
    var activeCoinToEdit : Coin?
    var portfolioCoins: [Coin]?
    var sortIndicatorLocation : arrowLocation?
    var portfolioSearch = false
    var portfolioValue: Double?
    var filterText:String = ""{
        willSet{
            if portfolioSearch{
                filterCoins(newValue: newValue , portfolioSearch: true)
            }
            else{
                filterCoins(newValue: newValue)
            }
        }
    }
    
    
    
    
    init(swiftDataManager : SwiftDataManager) {
        self.swiftDataManager  = swiftDataManager
        
        Task{
            if let marketData = await CoinService.retrieveStats(),let coins = await getCoins() {
                    await  MainActor.run {
                        allCoins = coins
                        filteredCoins = coins
                        marketStats = marketData
                        portfolioCoins = getPortfolioCoins()
                        portfolioFilteredCoins = portfolioCoins
                }
            }
        }

    }
    
    
    
    
    
    private func filterCoins(newValue:String, portfolioSearch:Bool = false){
        filterTask?.cancel()
        filterTask = Task {
            try? await Task.sleep(nanoseconds: 450_000_000) // 300ms delay
            
            if Task.isCancelled { return }
            
            if !portfolioSearch{
                let filteredCoins = if let coinsDisplayed = filteredCoins ,!newValue.isEmpty{
                    coinsDisplayed.filter {
                        $0.name.lowercased().contains(newValue.lowercased()) ||
                        $0.symbol.lowercased().contains(newValue.lowercased())
                    }
                } else {
                    filteredCoins ?? nil
                }
                
                await MainActor.run {
                    
                    allCoins = filteredCoins
                }
            }
            
            else{
                let filteredCoins = if let coinDisplayed = await getPortfolioCoins(), !newValue.isEmpty{
                     coinDisplayed.filter({
                         $0.name.lowercased().contains(newValue.lowercased()) ||
                         $0.symbol.lowercased().contains(newValue.lowercased())
                     })
                }else {
                    await getPortfolioCoins()
                }
                
                await MainActor.run {
                   
                    portfolioCoins = filteredCoins
                }
            }
            
            
        }
    }
    
    
    
    @MainActor func removeCoin(at indexSet : IndexSet){
        
        let holder = indexSet.map{  portfolioCoins?[$0] }
        
        if let coin = holder[0]{
                print(swiftDataManager.deleteCoin(coin))

        }
        portfolioCoins?.remove(atOffsets: indexSet)
        portfolioValue = portfolioCoins?.reduce(0){$0+$1.currentHoldingsValue}
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
    
    // MARK: - Helper Methods
    
    
    private func getDatabaseLocation(){
        
        let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
        
        let url = urlApp!.appendingPathComponent("default.store")
        
        if FileManager.default.fileExists(atPath: url.path) {
            print("swiftdata db at \(url.absoluteString)")
        }
    }
    
    
    
    
    // MARK: - Portfolio Methods
    

    @MainActor func getPortfolioCoins() -> [Coin]? {
        let fetchedResult = swiftDataManager.fetchPortfolio()
        if let portfolio = fetchedResult.first, !fetchedResult.isEmpty , let coins = allCoins {
            
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
            portfolioFilteredCoins = holder
            portfolioValue = holder.reduce(0){$0+$1.currentHoldingsValue}
            return holder
        }
        return nil
    }
    

    @MainActor func updatePortfolioCoinHolding( by amt: Double ){
        if let activeCoinToEdit {
            _ = self.swiftDataManager.editCoin(activeCoinToEdit, by:amt)
            
        }
    }
    
// MARK: - Coin List Sorting Methods
    
    
    @MainActor func sortByName(portfolio : Bool, ascending : Bool = true){
        sortIndicatorLocation = .symbol
        if let coins = allCoins , !portfolio{
            if ascending{
                var mutableCoins = coins
                mutableCoins.sort { $0.symbol < $1.symbol }
                allCoins = mutableCoins
            }else{
                var mutableCoins = coins
                mutableCoins.sort { $0.symbol > $1.symbol }
                allCoins = mutableCoins
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
        
        if let coins = allCoins , !portfolio{
            if ascending {
                var mutableCoins = coins
                mutableCoins.sort { $0.currentPrice < $1.currentPrice }
                allCoins = mutableCoins
            }
            else{
                var mutableCoins = coins
                mutableCoins.sort { $0.currentPrice > $1.currentPrice }
                allCoins = mutableCoins
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
    
    // MARK: - Enums
    
    
    enum  arrowLocation{
        case price
        case holdings
        case symbol
    }
    
    
    
}


// MARK: -  Error Handlers


enum PortfolioError : LocalizedError{
    case portfolioNotFound
    var errorDescription: String?{
        switch self {
        case .portfolioNotFound :
            return "portfolio not found"
        }
    }
}

