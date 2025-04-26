//
//  DetailedCoinView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 3/16/25.
//

import SwiftUI
import Charts

struct DetailedCoinView: View {
   var coinID : String
    var VM : CoinDetailsVM
    @State var expandDescription = false

    init(coinID: String) {
        VM = CoinDetailsVM(id:  coinID)
        self.coinID = coinID
    }
    
    var body: some View {
        Group{
            if VM.selectedDetailedCoin != nil{
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible(minimum:10, maximum: .infinity))], alignment: .leading) {
                        if let chartData = VM.selectedDetailedCoinChartData{
                            
                            CoinChart(data : chartData, VM: VM )
                                    .frame(minHeight: 250)
                        }
                        else{
                            ProgressView()
                        }
                        
                        Text("Overview").font(.title).fontWeight(.black)
                        if let description = VM.selectedDetailedCoin?.description?.en{
                            
                            coinDescription(description: description)
                                  
                            
                        }
                        
                        DetailedCoinInfoGrid(VM: VM)
                    }
                }.padding(.horizontal)
            }
            else{
                ProgressView()
            }
        }
       
        .navigationTitle(Text(coinID.capitalized))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    func  coinDescription (description: String) ->  some View {
        VStack(alignment: .leading){
            Text(description).lineLimit(expandDescription ? nil : 2 )
                .animation(.easeInOut(duration: 1.0), value: expandDescription)
               
               
            Text(expandDescription ? "less" : "Read More..")
               
                .foregroundStyle(.blue)
                
            
                .onTapGesture {
                    withAnimation(.easeInOut){
                        expandDescription.toggle()
                    }
                    
                }
            
        }
    }
    
   
    
}

//#Preview {
//    NavigationStack{
//        DetailedCoinView(coinID: "bitcoin")
//    }
//}
