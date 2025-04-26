//
//  CoinCard.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 2/9/25.
//

import SwiftUI

struct CoinCard: View {
    var coinURL:String
    var coinShortName:String
    var coinName:String
    
    var body: some View {
        ZStack{
            VStack{
                CoinImageView(url: coinURL, name: coinName).frame(width: 40,height: 40)
                Text("\(coinShortName.uppercased())")
                Text("\(coinName.capitalized)")
                    .foregroundStyle(Color.theme.secondaryText)
                    .lineLimit(1)
                   
            }.frame(minWidth: 113,maxWidth: 113, minHeight: 113, maxHeight: 113).clipShape(RoundedRectangle(cornerRadius: 19.0))
            RoundedRectangle(cornerRadius: 19.0)
            
                .stroke(Color.theme.secondaryText, lineWidth: 2.0).frame( minWidth: 120,maxWidth: 120, minHeight: 120, maxHeight: 120)
        }
    }
}

#Preview {
    CoinCard(coinURL: PreviewProvider.instance.coin.image, coinShortName: "BTC", coinName: "Eth3wdecccum")
}
