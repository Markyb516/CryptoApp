//
//  ModelContainer.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 2/23/25.
//

import Foundation
import SwiftData

@MainActor
class SwiftDataManager {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    @MainActor
    static let shared = SwiftDataManager()
    
    @MainActor
    private init() {
        // Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(for: PortfolioModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchPortfolio() -> [PortfolioModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<PortfolioModel>(predicate: #Predicate { !$0.portfolioCoins.isEmpty}))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addcoin(_ coin: PortfolioCoin) {
        modelContext.insert(coin)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func editCoin( _ activeCoin : Coin , by amt: Double) -> Bool{
        do {
            let foundCoin = try modelContext.fetch(FetchDescriptor<PortfolioCoin>(predicate: #Predicate { $0.name == activeCoin.name })).first
            let portfolio  = try modelContext.fetch(FetchDescriptor<PortfolioModel>(predicate: #Predicate { !$0.portfolioCoins.isEmpty })).first
            print(portfolio!)
            if foundCoin != nil {
                foundCoin?.currentHoldings += amt
                return true
            }
            else{
                if let portfolio {
                    let portfolioCoin = PortfolioCoin(id: activeCoin.id,
                                                      symbol:activeCoin.symbol
                                                      , name: activeCoin.name ,
                                                      currentHoldings: amt ,
                                                      portfolio: portfolio)
                    addcoin(portfolioCoin)
                    return true
                }
                
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        return false
    }
    func addExamples(){
        let portfolio = PortfolioModel(id: 1)
        let coin = PortfolioCoin(id: "bitcoin", symbol: "btc", name: "Bitcoin", currentHoldings: 1, portfolio: portfolio)
        modelContext.insert(coin)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}



