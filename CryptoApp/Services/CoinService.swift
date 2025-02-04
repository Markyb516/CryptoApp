//
//  CoinVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/23/25.
//

import Foundation

class CoinService  {
  private init(){}
    
      static func retrieveCoins() async throws -> [Coin] {
        if let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets") , var components = URLComponents(url: url, resolvingAgainstBaseURL: true){
            let urlQueryItems = [URLQueryItem(name: "vs_currency", value: "usd"),
                                 URLQueryItem(name: "sparkline", value: "true"),
                                 URLQueryItem(name: "price_change_percentage", value: "24h"),
                                 URLQueryItem(name: "x_cg_demo_api_key", value: "CG-3FRyPRKnHmiCnFpcgVWbXB6E")]
            components.queryItems = urlQueryItems
            if let componentsURL = components.url{
                do{     
                    return try await NetworkManager.getRequest(url: componentsURL, type: [Coin].self)
                }
                catch{
                    throw error
                }
            }
            throw URLError(.badURL)
        }
        throw URLError(.badURL)
    }
    
    func retrieveStats(){
        
    }
    
    
}

