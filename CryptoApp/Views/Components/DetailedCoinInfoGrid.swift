//
//  detailedCoinInfoGrid.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 4/12/25.
//

import SwiftUI

struct DetailedCoinInfoGrid: View {
    var VM : CoinDetailsVM

    var body: some View {
            Grid(alignment:.leading, verticalSpacing: 20){
             
                GridRow(alignment:.top){
                    currentPrice
                    marketCap
                }
                GridRow{
                        rank
                        volume
                    }
                
                Text("Additional Details").font(.title).fontWeight(.black)
                
                GridRow(alignment:.top){
                    high24Hr
                    low24Hr
                }
                
                GridRow(alignment:.top){
                        priceChange24Hr
                        marketCapChange24hr
                    }
                
                GridRow(alignment:.top){
                    blockTime
                    hashingAlgorithm
                }
            }
    }
    
    
    

    
    var currentPrice : some View{
        VStack(alignment:.leading){
            Text("Current Price")
            
            Text("\(VM.selectedDetailedCoin?.marketData.currentPrice.usd?.toCurrency() ?? "N/A" )")
            HStack{
                Image(systemName: VM.selectedDetailedCoin?.marketData.priceChangePercentage24H ?? -1 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill" ).foregroundStyle(VM.selectedDetailedCoin?.marketData.priceChangePercentage24H ?? -1 > 0 ? .greenApp : .redApp)
                Text("\(VM.selectedDetailedCoin?.marketData.priceChangePercentage24H?.toPercentage() ?? "N/A")")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    var marketCap : some View{
        VStack(alignment: .leading){
            Text("Market Capitalization")
            Text("\(VM.selectedDetailedCoin?.marketData.marketCap.usd?.marketDataFormat() ?? "N/A")")
            HStack{
                Image(systemName: VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H ?? -1 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill" )
                    .foregroundStyle(VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H ?? -1 > 0 ? .greenApp : .redApp)
                Text("\(VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H?.toPercentage() ?? "N/A" )")
            }.frame(  alignment: .leading)
        }
        .frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var rank : some View{
        VStack(alignment:.leading){
            Text("Rank")
            Text("\(VM.selectedDetailedCoin?.marketData.marketCapRank ?? 0)")
        }.frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var volume : some View{
        VStack{
            Text("Volume")
            Text("\(VM.selectedDetailedCoin?.marketData.totalVolume?.usd?.marketDataFormat() ?? "N/A")")
        }
        .frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var high24Hr : some View{
        VStack{
            Text("24h High")
            Text("\(VM.selectedDetailedCoin?.marketData.high24H?.usd?.toCurrency() ?? "N/A")")
        } .frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var low24Hr : some View{
        VStack{
            Text("24h Low")
            Text("\(VM.selectedDetailedCoin?.marketData.low24H.usd?.toCurrency() ?? "N/A")")
        } .frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var priceChange24Hr : some View{
        VStack(alignment:.leading){
            Text("24h Price Change")
            Text("\(VM.selectedDetailedCoin?.marketData.priceChangePercentage24HInCurrency.usd?.toCurrency() ?? "N/A")")
            HStack{
                Image(systemName: VM.selectedDetailedCoin?.marketData.priceChangePercentage24H ?? -1 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .foregroundStyle(VM.selectedDetailedCoin?.marketData.priceChangePercentage24H ?? -1 > 0 ? .greenApp : .redApp)
                Text("\(VM.selectedDetailedCoin?.marketData.priceChangePercentage24H?.toPercentage() ?? "N/A")")
            }
        } .frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var marketCapChange24hr : some View{
        VStack(alignment:.leading){
            Text("24h Market Cap Change").lineLimit(1)
                .minimumScaleFactor(0.3)
            
            Text("\(VM.selectedDetailedCoin?.marketData.marketCapChange24H?.marketDataFormat() ?? "N/A")")
            HStack{
                Image(systemName: VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H ?? -1 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .foregroundStyle( VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H ?? -1 > 0 ? .greenApp : .redApp)
                
                Text("\(VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H?.toPercentage() ?? "N/A")")
            }
        } .frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var blockTime : some View {
        VStack(alignment:.leading){
            Text("Block Time")
            Text("\(VM.selectedDetailedCoin?.blockTimeInMinutes?.formatToString(maxDecimal: 2, minDecimal: 2) ?? "N/A")")
        }
        .frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var hashingAlgorithm : some View {
        VStack(alignment:.leading){
            Text("Hashing Algorithm")
            Text("\(VM.selectedDetailedCoin?.hashingAlgorithm ?? "N/A")")
        }
        .frame( maxWidth: .infinity, alignment: .leading)
        
    }
}
//
//#Preview {
//    DetailedCoinInfoGrid()
//}
