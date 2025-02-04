//
//  StatisticsView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 2/3/25.
//

import SwiftUI

struct StatisticsView: View {
    var title:String
    var value:Double
    var percentageChange:Double?
    
    var body: some View {
        VStack{
            Text("\(title)")
            Text(value.toCurrency() ?? "$0.00" ).fontWeight(.heavy).font(.headline)
            if let percentageChange{
                HStack{
                    Image(systemName: value > 0 ? "triangleshape.fill" : "arrowtriangle.down.fill")
                    Text(percentageChange.toPercentage() ?? "0.00%")
                }.foregroundStyle(value > 0 ? .greenApp : .redApp)
            }
            
        }.font(.subheadline)
    }
}

#Preview {
    let statistic1 = StatisticsModel(title:"Market Cap", value: 2.56, percentageChange: 0.06)
    StatisticsView(title:statistic1.title, value: statistic1.value,percentageChange: statistic1.percentageChange)
}
