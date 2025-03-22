//
//  DetailedCoinDataModel.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 3/16/25.
//

import Foundation

struct DetailedCoinDataModel : Codable {
        let id, symbol, name, webSlug: String?
        let blockTimeInMinutes: Double?
        let hashingAlgorithm: String?
        let categories: [String]?
        let previewListing: Bool?
        let additionalNotices: [String]?
        let description: Description?
        let links: Links?
        let image: ImageLinks?
        let countryOrigin, genesisDate: String?
        let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?
        let watchlistPortfolioUsers, marketCapRank: Double?
        let lastUpdated: String?
}

struct Description : Codable {
    let en: String?
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

struct ImageLinks : Codable {
    let thumb, small, large: String?
}
