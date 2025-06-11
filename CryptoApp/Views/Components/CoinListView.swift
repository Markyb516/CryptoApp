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
    @Environment(HomeVM.self) private var homeVM

    
    var body: some View {
        if !portfolioView{
            List{
                ForEach(coins){ coin in
                    ZStack{
                        
                        CoinRowView(Coin: coin, showHoldings: portfolioView)
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10,trailing: 0))
                            .listRowSeparator(.hidden)
                            .background(
                                Rectangle().frame(height:1).padding(.top).padding(.top).padding(.top)
                            )
                        
                        NavigationLink("",value: coin.id)
                            .opacity(0.0)
                    }.listRowSeparator(.hidden)
                    
                    
                    
                }
            }.listStyle(.plain)
                .refreshable{homeVM.allCoins = await homeVM.getCoins()}
                .navigationDestination(for: String.self, destination: { id in
                    DetailedCoinView(coinID: id)
                })
        }
        else{
            List{
                ForEach(coins){ coin in
                    ZStack{
                        
                        CoinRowView(Coin: coin, showHoldings: portfolioView)
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10,trailing: 0))
                            .listRowSeparator(.hidden)
                            .background(
                                Rectangle().frame(height:1).padding(.top).padding(.top).padding(.top)
                            )
                        
                        NavigationLink("",value: coin.id)
                        .opacity(0.0)
                    }.listRowSeparator(.hidden)
                }
                .onDelete(perform: homeVM.removeCoin)
            }

            .listStyle(.plain)
            .refreshable{homeVM.portfolioCoins = homeVM.getPortfolioCoins()}
        
            .navigationDestination(for: String.self, destination: { id in
                DetailedCoinView(coinID: id)
            })
            
            
        }
        
    }
}

//#Preview {
//    CoinListView(coins: [PreviewProvider.instance.coin,PreviewProvider.instance.coin,PreviewProvider.instance.coin] , portfolioView: false)
//}
