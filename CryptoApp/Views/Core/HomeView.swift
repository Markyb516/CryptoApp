//
//  HomeView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/20/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio = false
    @Environment(HomeVM.self) private var homeVM
    
    var body: some View {
        ZStack{
            VStack{
                options
                    .padding(.horizontal)
                Spacer()
                coinHeaders
                
                if let coins = homeVM.allcoins , !showPortfolio{
                    CoinListView(coins: coins , portfolioView: false)
                        .transition(.move(edge: .leading))
                }
                else{
                    if let portfolioCoin = homeVM.portfolioCoins {
                        CoinListView(coins: portfolioCoin , portfolioView: true)
                            .transition(.move(edge: .trailing))
                    }
                    else{
                        ContentUnavailableView("Error", systemImage: "exclamationmark.triangle.fill",description: Text("No data is available"))
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
            NavigationButtonView(imageName: showPortfolio ? "plus" : "info" )
                .background(CircleAnimationButtonView(animate: $showPortfolio))
                .animation(.none , value: showPortfolio)
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
    
    
}

#Preview {
    @Previewable @State var homeVM = HomeVM()
    NavigationStack{
        HomeView()
            .environment(homeVM)
        
    }
}
