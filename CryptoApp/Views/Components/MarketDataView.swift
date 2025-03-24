//
//  StatisticsView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 2/3/25.
//

import SwiftUI

struct MarketDataView: View {
    var title:String
    var value:Double
    var percentageChange:Double?
    var percentageBased:Bool
    
    
    var body: some View {
        if percentageBased{
            percentageBasedMarketData
                .font(.subheadline)
                .frame(width: UIScreen.main.bounds.width * (0.30))
        }
        else{
            marketdata
                .font(.subheadline)
                .frame(width: UIScreen.main.bounds.width * (0.30))
        }
    }
    
    
    var marketdata:some View{
        VStack(alignment: .leading){
            Text("\(title)")
            Text("\(value.marketDataFormat() ?? "0.00")").fontWeight(.heavy).font(.headline)
            if let percentageChange{
                HStack{
                    Image(systemName: value > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    Text(percentageChange.toPercentage() ?? "0.00%")
                }.foregroundStyle(value > 0 ? .greenApp : .redApp)
            }
            
        }
    }
    
    var percentageBasedMarketData:some View{
        VStack(alignment: .leading){
            Text("\(title)")
            Text("\(value.marketDataFormat() ?? "0.00")%").fontWeight(.heavy).font(.headline)
        }
    }
}

#Preview {
    let statistic1 = StatisticsModel(title:"Market Cap", value: 256_761_000_999_000, percentageChange: 0.06)
    HStack{
        MarketDataView(title:statistic1.title, value: statistic1.value,percentageChange: statistic1.percentageChange,percentageBased: false)
        MarketDataView(title:statistic1.title, value: statistic1.value,percentageChange: statistic1.percentageChange,percentageBased: false)
        MarketDataView(title:statistic1.title, value: statistic1.value,percentageChange: statistic1.percentageChange,percentageBased: false)
    }.frame(maxWidth: .infinity)
    .background(.red)
}
