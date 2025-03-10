//
//  CoinListView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/26/25.
//

import SwiftUI

struct CoinListView: View {
    var coins : [Coin]
    var portfolioView : Bool
    
    var body: some View {
        List{
            ForEach(coins){ coin in
                CoinRowView(Coin: coin, showHoldings: portfolioView)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10,trailing: 0))
                    .listRowSeparator(.hidden)
                    .background(
                        Rectangle().frame(height:1).padding(.top).padding(.top).padding(.top)
                     
                    )
            }
        }
        .listStyle(.plain)
        
        
    }
}

//#Preview {
//    CoinListView(coins: [PreviewProvider.instance.coin,PreviewProvider.instance.coin,PreviewProvider.instance.coin] , portfolioView: false)
//}
