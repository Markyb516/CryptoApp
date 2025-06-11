//
//  CoinVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/23/25.
//

import Foundation

final class CoinService : Sendable {
  private init(){}
    static private let apiUrl = ProcessInfo.processInfo.environment["API_URL"]
    
      static func retrieveCoins() async throws -> [Coin] {
          if let apiUrl, let url  = URL(string: "\(apiUrl)coins/markets") , var components = URLComponents(url: url, resolvingAgainstBaseURL: true){
            let urlQueryItems = [URLQueryItem(name: "vs_currency", value: "usd"),
                                 URLQueryItem(name: "sparkline", value: "true"),
                                 URLQueryItem(name: "price_change_percentage", value: "24h"),
                                 ]
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
    
    
    
    static func retrieveStats() async -> MarketDataModel?{
        if let apiUrl , let url = URL(string: "\(apiUrl)global"){
            
            do{
               return try await NetworkManager.getRequest(url: url, type: MarketDataModel.self)
            }
            catch{
                print(error )
            }
            
        }
        return nil
    }
    
    
    
    static func retieveCoinHistory(id:String) async -> HistoricCoinDataModel?{
        if let apiUrl , let url = URL(string: "\(apiUrl)coins/\(id)/market_chart"), var components  = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            let urlQueryItems = [
                URLQueryItem(name: "vs_currency", value: "usd"),
                 URLQueryItem(name: "days", value: "7"),
                 URLQueryItem(name: "interval", value: "daily"),
                 URLQueryItem(name: "precision", value: "2"),
            ]

            
            components.queryItems = urlQueryItems
            if let componentsURL = components.url{
                do {
                    return try await NetworkManager.getRequest(url: componentsURL, type: HistoricCoinDataModel.self)
                }
                catch{
                    print(error)
                }
            }
        }
        return nil
    }
    
    
    static func retrieveCoinData(id:String) async -> DetailedCoinDataModel?{
        if let apiUrl , let url = URL(string: "\(apiUrl)coins/\(id)"){
            do{
               return try await NetworkManager.getRequest(url: url, type: DetailedCoinDataModel.self)
            }
            catch{
                print(error)
                return nil
            }
        }
        return nil
    }
    
}

