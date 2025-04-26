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
   var VM : HomeVM
    @State var showMark = false
    @State var pricez = 0.0
    @State var datez = ""
    var body: some View {
        ZStack{
            if VM.selectedDetailedCoin != nil{
                
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible(minimum:10, maximum: .infinity))], alignment: .leading) {
                        if let chartData = VM.selectedDetailedCoinChartData{
                            VStack {
                                if showMark{
                                    Text("Price:\(pricez) Day: \(datez)" )
                                }
                                chart(data: chartData)
                                    .frame(minHeight: 250)
                            }
                        }
                        else{
                            ProgressView()
                        }
                        
                        
                            
                        Text("Overview").font(.title).fontWeight(.black)
                        
                        
                        coinData
                        
                        
                        
                    }
                }.padding(.horizontal)
                
                
                
                
                
            }
            else{
                ProgressView()
            }
         
        }
        .task {
            await VM.getCoinDetails(id: coinID)
        }
        .navigationTitle(Text(coinID.capitalized))
    }
    
    
    func chart( data : [DailyCoinData]) -> some View {
        Chart(data) {
            LineMark(x: .value("Day", $0.date), y: .value("Price", $0.price))
                .foregroundStyle(.greenApp)
            if let test = VM.test , showMark{
                
                RuleMark(x:.value("selection", test))
                    
            }
            
        }
            .chartXAxis{
                AxisMarks(values: .stride(by: .month, count: 1)) { value in
                            AxisTick()
                            AxisValueLabel(format: .dateTime.month(.abbreviated))
                        }
            }
            .chartYAxis{
                AxisMarks(stroke:StrokeStyle(lineWidth: 2.5))
            }
            .chartOverlay { chartProxy in
                GeometryReader { geometry in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance:0)
                                .onChanged({ value in
                                    guard let plug = chartProxy.plotFrame else{return}
                                    let origin = geometry[plug].origin
                                    
                                    let location = CGPoint(
                                                                x: value.location.x - origin.x,
                                                                y: value.location.y - origin.y
                                                            )
                                    if let (date, price) = chartProxy.value(at: location, as: (Date, Double).self){
                                        
                                        pricez = price
                                        datez = date.formatted(.dateTime)
                                        
                                        VM.test = date
                                        showMark = true
                                    }
                        
                                })
                                .onEnded({ value in
                                    showMark = false
                                })
                            
                            
                        )
                }
            }
            
    }
    
    var coinData : some View {
        Grid(alignment:.leading, verticalSpacing: 20){
            GridRow(alignment:.top){
                currentPrice
                  

                
                marketCap
            }
            
                GridRow{
                    rank
                    volume
                }
            Text("Additional Details").font(.title).fontWeight(.black)
            
            GridRow(alignment:.top){
                high24Hr
                low24Hr
            }
            
            GridRow(alignment:.top){
                    priceChange24Hr
                    marketCapChange24hr
                }
            GridRow(alignment:.top){
                blockTime
                hashingAlgorithm
            }
        }
        
        
        
    }
    
    
    var currentPrice : some View{
        VStack(alignment:.leading){
            Text("Current Price")
            
            Text("\(VM.selectedDetailedCoin?.marketData.currentPrice.usd?.toCurrency() ?? "N/A" )")
            HStack{
                Image(systemName: VM.selectedDetailedCoin?.marketData.priceChangePercentage24H ?? -1 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill" )
                Text("\(VM.selectedDetailedCoin?.marketData.priceChangePercentage24H?.toPercentage() ?? "N/A")")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
       
    }
    
    var marketCap : some View{
        VStack(alignment: .leading){
            Text("Market Capitalization")
            Text("\(VM.selectedDetailedCoin?.marketData.marketCap.usd?.marketDataFormat() ?? "N/A")")
            HStack{
                Image(systemName: VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H ?? -1 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill" )
                Text("\(VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H?.toPercentage() ?? "N/A" )")
            }.frame(  alignment: .leading)
        }
        .frame( maxWidth: .infinity, alignment: .leading)
       
    }
    
    var rank : some View{
        VStack(alignment:.leading){
            Text("Rank")
            Text("\(VM.selectedDetailedCoin?.marketData.marketCapRank ?? 0)")
        }.frame( maxWidth: .infinity, alignment: .leading)
           
    }
    
    var volume : some View{
        VStack{
            Text("Volume")
            Text("\(VM.selectedDetailedCoin?.marketData.totalVolume?.usd?.marketDataFormat() ?? "N/A")")
        }
        .frame( maxWidth: .infinity, alignment: .leading)
            
    }
    
    var high24Hr : some View{
        VStack{
            Text("24h High")
            Text("\(VM.selectedDetailedCoin?.marketData.high24H?.usd?.toCurrency() ?? "N/A")")
        } .frame( maxWidth: .infinity, alignment: .leading)
            
    }
    
    var low24Hr : some View{
        VStack{
            Text("24h Low")
            Text("\(VM.selectedDetailedCoin?.marketData.low24H.usd?.toCurrency() ?? "N/A")")
        } .frame( maxWidth: .infinity, alignment: .leading)
            
    }
    
    var priceChange24Hr : some View{
        VStack(alignment:.leading){
            Text("24h Price Change")
            Text("\(VM.selectedDetailedCoin?.marketData.priceChangePercentage24HInCurrency.usd?.toCurrency() ?? "N/A")")
            HStack{
                Image(systemName: VM.selectedDetailedCoin?.marketData.priceChangePercentage24H ?? -1 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                Text("\(VM.selectedDetailedCoin?.marketData.priceChangePercentage24H?.toPercentage() ?? "N/A")")
            }
        } .frame( maxWidth: .infinity, alignment: .leading)
            
    }
    
    var marketCapChange24hr : some View{
        VStack(alignment:.leading){
            Text("24h Market Cap Change").lineLimit(1)
                .minimumScaleFactor(0.3)
                
            Text("\(VM.selectedDetailedCoin?.marketData.marketCapChange24H?.marketDataFormat() ?? "N/A")")
            HStack{
                Image(systemName: VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H ?? -1 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
            
                Text("\(VM.selectedDetailedCoin?.marketData.marketCapChangePercentage24H?.toPercentage() ?? "N/A")")
            }
        } .frame( maxWidth: .infinity, alignment: .leading)
          
    }
    
    var blockTime : some View {
        VStack(alignment:.leading){
            Text("Block Time")
            Text("\(VM.selectedDetailedCoin?.blockTimeInMinutes?.formatToString(maxDecimal: 2, minDecimal: 2) ?? "N/A")")
        }
        .frame( maxWidth: .infinity, alignment: .leading)
        
    }
    
    var hashingAlgorithm : some View {
        VStack(alignment:.leading){
            Text("Hashing Algorithm")
            Text("\(VM.selectedDetailedCoin?.hashingAlgorithm ?? "N/A")")
        }
        .frame( maxWidth: .infinity, alignment: .leading)
       
    }
    
}

#Preview {
    NavigationStack{
        DetailedCoinView(coinID: "ethereum", VM: HomeVM(swiftDataManager: SwiftDataManager.shared))
    }
}
