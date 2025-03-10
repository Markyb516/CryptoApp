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
    @Environment(HomeVM.self) private var homeVM
    @State var open = true
    
    
    var body: some View {
        ZStack{
            VStack{
                options
                    .padding(.horizontal)
                
                if showPortfolio{
                    portfolioMarketData
                }
                else {
                    if homeVM.marketStats != nil {
                    livePricesMarketData
                    }
                    else{
                        ProgressView()
                    }
                }
                
                SearchBarView(VM: homeVM)
                coinHeaders.padding(.horizontal)
                
                if let coins = homeVM.allcoins , !showPortfolio{
                    CoinListView(coins: coins , portfolioView: false)
                        .padding(.horizontal)
                        .transition(.move(edge: .leading))
                }
                else{
                    // need to fix the portfolioCoin functionality
                    if let portfolioCoin =  homeVM.portfolioCoins(){
                        CoinListView(coins: portfolioCoin , portfolioView: true)
                            .padding(.horizontal)
                            .transition(.move(edge: .trailing))
                    }
                }
            
            }
            
        }
    }
    
    
    
    
    private var coinHeaders : some View {
        HStack{
            Text("Coin")
            Spacer()
            HStack{
                if showPortfolio{
                    Text("Holdings")
                    Spacer()
                }
                Text("Price")
            }.frame(width: UIScreen.main.bounds.width * (2/4), alignment: .trailing)
            
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        
    }
    
    private var options: some View {
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
                open.toggle()
            }) {
                AddHoldingsView( VM: homeVM)
            }
        
            

    }
    var infoButton:some View{
        NavigationButtonView(imageName: "info")
            .background(CircleAnimationButtonView(animate: $showPortfolio))
            .animation(.none , value: showPortfolio)

    }
    
    private var livePricesMarketData:some View {
        HStack(alignment:.top ){
            MarketDataView(title: "Market Cap", value: homeVM.marketStats?.marketCap ?? 0, percentageChange: homeVM.marketStats?.marketPecentageChange ,percentageBased: false)
                  
            MarketDataView(title: "24h Volume", value: homeVM.marketStats?.marketVolume ?? 0, percentageBased: false)
                  
            MarketDataView(title: "BTC Dominance", value: homeVM.marketStats?.btcMarketDominance ?? 0 , percentageBased: true)
        }
        .transition(.move(edge: .leading))
        
    }
    
    private var portfolioMarketData:some View{
        
        HStack(alignment: .top) {
            MarketDataView(title: "24h Volume", value: homeVM.marketStats?.marketVolume ?? 0, percentageBased: false)
               
            MarketDataView(title: "BTC Dominance", value: homeVM.marketStats?.btcMarketDominance ?? 0 ,percentageBased: true)
            
            MarketDataView(title: "Portfolio Value", value: 499, percentageChange: 0.70 , percentageBased: false)
        }.transition(.move(edge: .trailing))
    }
    
    
}

#Preview {
    
     var homeVM = HomeVM(swiftDataManager:SwiftDataManager.shared)
  
     NavigationStack{
        HomeView()
            .environment(homeVM)
        
     }  

}
