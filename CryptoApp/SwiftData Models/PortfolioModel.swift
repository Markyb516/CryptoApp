    //
    //  PortfolioModel.swift
    //  CryptoApp
    //
    //  Created by Markus Buchanan on 2/22/25.
    //

    import SwiftUI
    import SwiftData


    @Model class PortfolioModel{
        @Attribute(.unique) var id : Int
        @Relationship(deleteRule: .cascade , inverse: \PortfolioCoin.portfolio) var portfolioCoins : [PortfolioCoin] = []

        init(id: Int, portfolioCoins: [PortfolioCoin] = []) {
            self.id = id
            self.portfolioCoins = portfolioCoins
        }
        
      
    }
