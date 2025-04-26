//
//  CoinDetailsVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 4/6/25.
//

import Foundation

@Observable class CoinDetailsVM{
    
    var selectedDetailedCoin:DetailedCoinDataModel?
    var selectedDetailedCoinChartData: [DailyCoinData]?
    
    init(id:String){
        Task{
            await getCoinDetails(id: id)
        }
    }
    
    @MainActor func getCoinDetails(id:String) async {
        Task{
            if let coinData = await CoinService.retrieveCoinData(id: id),
               let result = await CoinService.retieveCoinHistory(id: id) {
                
                selectedDetailedCoin = coinData
                selectedDetailedCoinChartData = result.chartDataPoints
            }
        }
    }
    
    
// MARK: - Testing Init
    init(){
        // Testing init -----------------------
        let now = Date()
        let calendar = Calendar.current
        let date0 = now
        let date1 = calendar.date(byAdding: .day, value: -1, to: now)!
        let date2 = calendar.date(byAdding: .day, value: -2, to: now)!
        let date3 = calendar.date(byAdding: .day, value: -3, to: now)!
        let date4 = calendar.date(byAdding: .day, value: -4, to: now)!
        let date5 = calendar.date(byAdding: .day, value: -5, to: now)!
        let date6 = calendar.date(byAdding: .day, value: -6, to: now)!
        
        selectedDetailedCoin = DetailedCoinDataModel(id: "bitcoin", symbol: "btc", name: "bitcoin", blockTimeInMinutes: 20.00, hashingAlgorithm: "testing", previewListing: true, additionalNotices: ["sdsdsds"], description: Description(en: "nkjnjknjknjknjknjnjknjknkjnkjknjknjknjnjknjknbjbnbnmbnbnmbjhbbjkhbkjbjkbjkbjkbjbjbjkbjbjbnmb mnbhjbjhbkjbjkbjkbkjbkjbjkbkjbjkbkjbjkbjbhbhbhbhv hjvhv bm mbhbjbkbjkbjbjkbjbkjbjbjkbjkbkjbjkbkjbjkbjbjhbhjbvv bmnbjh,vg bnv hgvvb g,vghv hj hv hv,hvhj hvhvb hgjv h,knknjkjkn hjv v ,hv,vhj,vhvhvh,bh,b,b,jb"),
                                                     
                                                     
                                                     
                                                     links: Links(homepage: ["dasdsd"], whitepaper: "dsdss", blockchainSite: nil, officialForumURL: nil, chatURL: nil, announcementURL: nil, twitterScreenName: "ewdewd", facebookUsername: nil, telegramChannelIdentifier: nil, subredditURL: nil), countryOrigin: "us", genesisDate: nil, marketData: MarketData(currentPrice: CurrentPrice(usd: 23232323.3232), marketCap: MarketCap(usd: 332322332.232), priceChangePercentage24HInCurrency: PriceChangePercentage24hInCurrency(usd: 23323232), priceChangePercentage24H: -32.32, high24H: High24hr(usd: 3233232), low24H: Low24hr(usd: 323232), totalVolume: TotalVolume(usd: 321323), marketCapRank: 1.23, marketCapChangePercentage24H: 23.3232, marketCapChange24H: 3232.3232))
        
        selectedDetailedCoinChartData = [
            DailyCoinData(price: 70_500_.23, date: date0),
            DailyCoinData(price: 70_600_.23, date: date1),
            DailyCoinData(price: 80_100_.23, date: date2),
            DailyCoinData(price: 50_100_.23, date: date3),
            DailyCoinData(price: 60_100_.23, date: date4),
            DailyCoinData(price: 74_100_.23, date: date5),
            DailyCoinData(price: 78_100_.23, date: date6),
        ]
    }
 
    
    
    
    
    
    
}

