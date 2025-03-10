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
    
    
    
/// tjhhjbhbjhbjh
    static func retrieveStats() async -> MarketDataModel?{
        if let url = URL(string: "https://api.coingecko.com/api/v3/global"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "x-cg-demo-api-key": "CG-3FRyPRKnHmiCnFpcgVWbXB6E"
            ]
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let decoder =  JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
            
                return try decoder.decode(MarketDataModel.self, from: data)
                
            }
            catch{
                print(error)
                return nil
            }
            
        }
        return nil
    }
    
    
}

