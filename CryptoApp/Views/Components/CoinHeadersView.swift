//
//  CoinHeadersView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 3/10/25.
//

import SwiftUI

struct CoinHeadersView: View {
    @Binding var showPortfolio: Bool
    @Environment(HomeVM.self) private var homeVM
    @State var nameSorting = true
    @State var holdingsSorting = true
    @State var priceSorting = true
    
    
    var body: some View {
        HStack{
            HStack{
                Text("Coin")
                    .onTapGesture {
                        homeVM.sortByName(portfolio: showPortfolio,ascending: nameSorting)
                        nameSorting.toggle()
                       
                    }
                
                if homeVM.sortIndicatorLocation == .symbol{
                    Image(systemName:  nameSorting ? "arrow.down": "arrow.up")
                }
                
            }
            
            
            Spacer()
            HStack{
            
                if showPortfolio{
                    HStack{
                        Text("Holdings")
                            .onTapGesture {
                                
                                homeVM.sortByHoldings( ascending: holdingsSorting)
                                holdingsSorting.toggle()
                                
                            }
                        
                        if homeVM.sortIndicatorLocation == .holdings{
                            Image(systemName: holdingsSorting ? "arrow.down": "arrow.up")
                        }
                    }
                       
                    Spacer()
                }
                
                HStack{
                    Text("Price")
                        .onTapGesture {
                            homeVM.sortByPrice(portfolio: showPortfolio, ascending: priceSorting)
                            priceSorting.toggle()
                        }
                    if homeVM.sortIndicatorLocation == .price{
                        Image(systemName: priceSorting ? "arrow.down": "arrow.up" )
                    }
                }
            }.frame(width: UIScreen.main.bounds.width * (2/4), alignment: .trailing)
            
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        
    }
}

#Preview {
    @Previewable @State var showPortfolio: Bool = false
    
    CoinHeadersView(showPortfolio: $showPortfolio)
        .environment(HomeVM(swiftDataManager: SwiftDataManager.shared))
}
