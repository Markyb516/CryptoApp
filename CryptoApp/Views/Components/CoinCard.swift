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
        VStack{
            CoinImageView(url: coinURL, name: coinName).frame(width: 40,height: 40)
            Text("\(coinShortName.uppercased())")
            Text("\(coinName.capitalized)").multilineTextAlignment(.center)
                .foregroundStyle(Color.theme.secondaryText)
        }.frame(width:120, height: 120)
            .background(
            RoundedRectangle(cornerRadius: 19.0)
                
                .stroke(Color.theme.secondaryText, lineWidth: 2.0)
        )
    }
}
//
//#Preview {
//    CoinCard(coinURL: PreviewProvider.instance.coin.image, coinShortName: "BTC", coinName: "Bitcjknjnjnjnjoin")
//}
