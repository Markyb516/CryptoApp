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
    @State var incorrect = false
    @FocusState private var qtyFocus : Bool
    
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                SearchBarView(VM: VM).padding(.horizontal)
                    
                
                if let coins = VM.allCoins{
                    coinList(coins: coins)
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
                    VStack{
                        CoinCard(coinURL: coin.image, coinShortName: coin.symbol, coinName: coin.name)
                        if coin.name == selectedCoin{
                            Rectangle()
                                .fill(.secondary)
                                .frame(width: 48, height: 3)
                                
                        }
                    }
                        .onTapGesture {
                        selectedCoin = coin.name
                        coinPrice = coin.currentPrice
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
            VM.portfolioCoins = VM.getPortfolioCoins()
            dismiss.callAsFunction()
        } label: {
            Image(systemName: "xmark")
        }
        .font(.title3)
    }
    
    
    var form:some View {
        VStack(alignment: .leading) {
            Button(action: {
                showForm = false
                selectedCoin = ""
                VM.activeCoinToEdit = nil
            }, label: {
                Text("Cancel")
                    .foregroundStyle(.white)
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .fill(.red)
                    )
            })
                .padding()
            currentPrice
                .padding()
            customDiver
            
            portfolioAmount
                .padding()
            customDiver
            
            currentValue
                .padding()
            customDiver
        
            submitButton
                .padding()
        }
        
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
            Text("Value:")
            Spacer()
            Text("\(coinPrice * (Double(portfolioAMT) ?? 0) )")
        }
    }
    
    var portfolioAmount : some View{
        HStack {
            Text("QTY") // Moved the descriptive text *outside* the TextField's HStack
            Spacer()
            VStack{
             
                TextField("QTY", text: $portfolioAMT, axis: .vertical)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth:90, minHeight: 30,maxHeight: 30)
                    .border(!incorrect ?  .secondaryText : .redApp )
                    .multilineTextAlignment(.trailing)
                    .lineLimit(7)
                    .keyboardType(.numberPad)
                    .submitLabel(.done)
                    .focused($qtyFocus)
                    .onAppear {
                        Task{
                            try? await Task.sleep(nanoseconds: 3_000_000)
                            qtyFocus = true
                        }
                    }
            }
        }
    }
    
    
    var customDiver : some View {
        Divider().overlay {
            Rectangle().fill(.black).frame(height: 2)
        }.padding(.horizontal)
       
       
    }
    
    var submitButton : some View{
        Button {
            if let qtyAMT = Double(portfolioAMT){
                VM.updatePortfolioCoinHolding(by: qtyAMT)
                selectedCoin = ""
                VM.activeCoinToEdit = nil
                showForm = false
                portfolioAMT = ""
            }
            else{
                incorrect = true
            }
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
    
    
    AddHoldingsView(VM:HomeVM(swiftDataManager: SwiftDataManager.shared))
}
