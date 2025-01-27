//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/21/25.
//

import SwiftUI

struct CoinRowView: View {
    let Coin : Coin
    let showHoldings : Bool
    var body: some View {
        HStack{
            coinIcon
            Spacer()
            coinDetails
        }.font(.subheadline)
    }
    
    
    var coinIcon : some View {
        HStack {
            Circle()
                .frame(maxWidth: 30 , maxHeight: 30)
            Text(Coin.symbol.uppercased())
        }
    }
    
    var coinDetails : some View {
        
        HStack() {
            if showHoldings {
                VStack(alignment: .trailing){
                    Text(Coin.currentHoldingsValue.toCurrency() ?? "0")
                    Text(Coin.currentHoldings?.formatToString(maxDecimal: 6, minDecimal: 2) ?? "0")
                }
                Spacer()
            }
        
            VStack(alignment:.trailing){
                Text(Coin.currentPrice.toCurrency() ?? "0")
                Text(Coin.priceChangePercentage24H?.toPercentage() ?? "0.00%")
                    .foregroundStyle(Coin.priceChangePercentage24H ?? 0 > 0 ? .greenApp : .redApp)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width * (2/4), alignment: .trailing)
        
    }
}

#Preview {
    
    CoinRowView(Coin: PreviewProvider.instance.coin , showHoldings: true)
    
    

    
}


#Preview(traits: .sizeThatFitsLayout) {
    
    CoinRowView(Coin: PreviewProvider.instance.coin , showHoldings: false)
    

    
}
