//
//  HomeView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/20/25.
//

import SwiftUI
import SwiftData
struct HomeView: View {
    @State private var showPortfolio = false
    @State private var addCoin = false
    @State private var viewSettings = false

    @Environment(HomeVM.self) private var homeVM
    
    var body: some View {
       
            VStack{
                settings
                    .padding(.horizontal)
                ZStack{
                    if showPortfolio{
                        portfolioMarketData
                          

                            .transition(.move(edge: .trailing))
                    }
                    else {
                        if homeVM.marketStats != nil {
                            livePricesMarketData
                                .transition(.move(edge: .leading))
                        }
                        else{
                            ProgressView()
                        }
                    }
                }.clipped()
                
                SearchBarView(VM: homeVM)
                CoinHeadersView(showPortfolio: $showPortfolio)
                    .padding(.horizontal)
                
                if let coins = homeVM.allCoins , !showPortfolio{
                    CoinListView(coins: coins , portfolioView: false)
                       
                      
                        .transition(.move(edge: .leading))
                }
                else{
                    // need to fix the portfolioCoin functionality
                    if let portfolioCoin =  homeVM.portfolioCoins{
                        CoinListView(coins: portfolioCoin , portfolioView: true)
                            
                        
                            .transition(.move(edge: .trailing))
                        
                    }
                    else{
                        
                        MissingPortfolioCoinsView()
                    }
                }
            
            }
            
            
        }
       
    
    
    
    
    
   
    
    private var settings: some View {
        HStack{
            if showPortfolio{
                plusButton
            }
            else{
                infoButton
            }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.black)
                .foregroundStyle(Color.theme.accent)
                .animation(.none , value: showPortfolio)
            Spacer()
            NavigationButtonView(imageName: "chevron.right" ).rotationEffect( .degrees(showPortfolio ? 180 : 0) )
                .onTapGesture {
                    withAnimation(.smooth) {
                        homeVM.sortIndicatorLocation = nil
                        showPortfolio.toggle()
                    }
                }
        }
    }
    
    
    var plusButton:some View {
        NavigationButtonView(imageName: "plus")
            .background(CircleAnimationButtonView(animate: $showPortfolio))
            .animation(.none , value: showPortfolio)
            .onTapGesture {
                addCoin.toggle()
            }
            .sheet(isPresented: $addCoin,onDismiss: {
                print("sheeet ")

            }) {
                AddHoldingsView( VM: homeVM)
            }
            
    }
    var infoButton:some View{
        NavigationButtonView(imageName: "info")
            .background(CircleAnimationButtonView(animate: $showPortfolio))
            .animation(.none , value: showPortfolio)
            .onTapGesture {
                viewSettings.toggle()
            }
            .fullScreenCover(isPresented: $viewSettings, content: {
                SettingsView()
            })
          
    }
    
    private var livePricesMarketData:some View {
        HStack(alignment:.top ){
            MarketDataView(title: "Market Cap", value: homeVM.marketStats?.marketCap ?? 0, percentageChange: homeVM.marketStats?.marketPecentageChange ,percentageBased: false)
                  
            MarketDataView(title: "24h Volume", value: homeVM.marketStats?.marketVolume ?? 0, percentageBased: false)
                  
            MarketDataView(title: "BTC Dominance", value: homeVM.marketStats?.btcMarketDominance ?? 0 , percentageBased: true)
        }
       
        
    }
    
    private var portfolioMarketData:some View{
        
        HStack(alignment: .top) {
            MarketDataView(title: "24h Volume", value: homeVM.marketStats?.marketVolume ?? 0, percentageBased: false)
               
            MarketDataView(title: "BTC Dominance", value: homeVM.marketStats?.btcMarketDominance ?? 0 ,percentageBased: true)
            
            MarketDataView(title: "Portfolio Value", value: homeVM.portfolioValue ?? 0 , percentageBased: false)
        }
       
     
       
    }
    
    
}

#Preview {
    
     let homeVM = HomeVM(swiftDataManager:SwiftDataManager.shared)
  
     NavigationStack{
        HomeView()
            .environment(homeVM)
        
     }  

}
