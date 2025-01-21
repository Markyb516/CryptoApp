//
//  HomeView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/20/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio = false

    var body: some View {
        
        ZStack{
            Color.theme.background.ignoresSafeArea()
            
            VStack{
                HStack{
                    NavigationButtonView(imageName: showPortfolio ? "plus" : "info" )
                        .background(
                            CircleAnimationButton(animate: $showPortfolio)
                        )
                        .animation(.none , value: showPortfolio)
                    Spacer()
                    Text(showPortfolio ? "Portfolio" : "Live Prices")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.theme.accent)
                        .shadow(radius: 2.0)
                        .animation(.none , value: showPortfolio)
                    
                    Spacer()

                    NavigationButtonView(imageName: "chevron.right" ).rotationEffect( .degrees(showPortfolio ? 180 : 0) )
                        .onTapGesture {
                            withAnimation(.smooth) {
                                showPortfolio.toggle()
                            }
                          
                        }

                    
                }
                .padding(.horizontal)
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
            
    }
}
