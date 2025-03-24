//
//  DetailedCoinDataModel.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 3/16/25.
//

import Foundation

struct DetailedCoinDataModel : Codable {
        let id, symbol, name: String?
        let blockTimeInMinutes: Double?
        let hashingAlgorithm: String?
       
        let previewListing: Bool?
        let additionalNotices: [String]?
        let description: Description?
        let links: Links?
    
        let countryOrigin, genesisDate: String?
  
      
        let marketData : MarketData
       
       
    
}

struct Description : Codable {
    let en: String?
}

struct High24hr: Codable {
    let usd : Double?
}

struct Low24hr: Codable {
    let usd : Double?
}

struct TotalVolume : Codable{
    let usd : Double?
}


struct MarketData : Codable {
    let currentPrice : CurrentPrice
    let marketCap : MarketCap
    let priceChangePercentage24HInCurrency : PriceChangePercentage24hInCurrency
    let priceChangePercentage24H : Double?
    let high24H : High24hr?
    let low24H : Low24hr
    let totalVolume : TotalVolume?
    let marketCapRank: Double?
    let marketCapChangePercentage24H : Double?
    let marketCapChange24H : Double?
}

struct MarketCap : Codable {
    let usd : Double?
}

struct CurrentPrice : Codable {
    let usd : Double?
}

struct PriceChangePercentage24hInCurrency : Codable{
    let usd : Double?
}


struct Links : Codable {
    let homepage: [String]?
    let whitepaper: String?
    let blockchainSite, officialForumURL: [String]?
    let chatURL, announcementURL: [String]?
    let twitterScreenName, facebookUsername: String?
    let telegramChannelIdentifier: String?
    let subredditURL: String?
}


