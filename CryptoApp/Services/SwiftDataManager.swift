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
    
    static let shared = SwiftDataManager()
    
   
    private init() {
        // Change isStoredInMemoryOnly to false if you would like to see the data persistance after exiting the app
        self.modelContainer = try! ModelContainer(for: PortfolioModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
// MARK: - Methods
    
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
            print(foundCoin?.name ?? "swift data : No coin found" )
            print(foundCoin?.currentHoldings ?? "swift data : No coin holdings found" )
            let portfolio  = try modelContext.fetch(FetchDescriptor<PortfolioModel>(predicate: #Predicate { !$0.portfolioCoins.isEmpty })).first
            
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
                else{
                    let createdPortfolio = PortfolioModel(id: 1)
                    let portfolioCoin = PortfolioCoin(id: activeCoin.id,
                                                      symbol:activeCoin.symbol
                                                      , name: activeCoin.name ,
                                                      currentHoldings: amt ,
                                                      portfolio: createdPortfolio)
                    addcoin(portfolioCoin)
                    return true
                    
                }
                
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
    }
//    func addExamples(){
//        let portfolio = PortfolioModel(id: 1)
//        let coin = PortfolioCoin(id: "bitcoin", symbol: "btc", name: "Bitcoin", currentHoldings: 1, portfolio: portfolio)
//        modelContext.insert(coin)
//        do {
//            try modelContext.save()
//        } catch {
//            fatalError(error.localizedDescription)
//        }
//    }
}



