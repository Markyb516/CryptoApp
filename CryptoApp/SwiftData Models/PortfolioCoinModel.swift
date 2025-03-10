//
//  PortfolioCoinModel.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 2/22/25.
//

import Foundation
import SwiftData


@Model class PortfolioCoin : Identifiable {
    @Attribute(.unique) var id: String
    var symbol: String
    var name : String
    var currentHoldings : Double
    var portfolio : PortfolioModel
    init(id: String, symbol: String, name: String, currentHoldings: Double = 0 , portfolio : PortfolioModel) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.currentHoldings = currentHoldings
        self.portfolio = portfolio
      
    }
    
}
