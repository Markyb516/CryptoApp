//
//  AddHoldingsView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 2/9/25.
//

import SwiftUI
import SwiftData

struct AddHoldingsView: View {
    @Environment(\.dismiss) var dismiss
    @State var coinPrice = 0.00
    @State var selectedCoin = ""
    @State var portfolioAMT = ""
    @State var holdingsValue = 0.00
    @State var showForm = false
  
    
    
    var VM : HomeVM
    
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                SearchBarView(VM: VM).padding(.horizontal)
                
                if let coins = VM.allcoins{
                    coinList(coins: coins)
                        .padding(.bottom)
                }
                else{
                    ProgressView()
                }
                if showForm{
                    form
                }
                
                Spacer()
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    exitButton
                }
            }
        }
        
    }
    
    
    
    
    
    func coinList(coins:[Coin] ) ->  some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHStack(spacing:15){
                ForEach(coins){ coin in
                    CoinCard(coinURL: coin.image, coinShortName: coin.symbol, coinName: coin.name).onTapGesture {
                        selectedCoin = coin.name
                        coinPrice = coin.currentPrice
                        portfolioAMT = String(0.0)
                        VM.activeCoinToEdit = coin
                        showForm = true
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: 150)
                .padding(.leading,5)
        }
    }
    
    var exitButton:some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            Image(systemName:"xmark")
        }
        .font(.title3)
    }
    
    
    var form:some View {
        VStack {
            currentPrice
            .padding(.vertical)
            
            customDiver
            
            portfolioAmount
                   .padding(.vertical)
            
            customDiver
            
            currentValue
                .padding(.vertical)
            
            customDiver
            
            submitButton.padding(.top)
        }
        .padding(.horizontal)
    }
    
    
    var currentPrice : some View {
        HStack{
            Text("Current price of: \(selectedCoin)")
            Spacer()
            Text("$\(coinPrice.formatToString(maxDecimal: 2, minDecimal: 2) ?? "0.00")")
        }
    }
    
    var currentValue : some View{
        HStack{
            Text("Current value:")
            Spacer()
            Text("\(coinPrice * (Double(portfolioAMT) ?? 0) )")
        }
    }
    
    var portfolioAmount : some View{
        HStack {
            Text("Amount in your portfolio") // Moved the descriptive text *outside* the TextField's HStack
            Spacer()
            VStack{
             
                TextField("QTY", text: $portfolioAMT, axis: .vertical) // Use the placeholder as the label!
                    .textFieldStyle(.roundedBorder) // Or another visible style
                    .frame(maxWidth:90, maxHeight: 30)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(7)
                    .keyboardType(.numberPad)
            }
        }
    }
    
    
    var customDiver : some View {
        Rectangle().frame(width:.infinity, height: 1)
    }
    
    var submitButton : some View{
        Button {
            VM.updatePortfolioCoinHolding(by: Double(portfolioAMT) ?? 0.0)
            showForm = false
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(Color.blue.opacity(0.6))
                    .frame(height: 60)
                Text("Submit")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
        }
    }
}
//
#Preview {
    
    
    AddHoldingsView( VM: HomeVM(swiftDataManager: SwiftDataManager.shared))
}
