//
//  CoinChart.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 4/12/25.
//

import SwiftUI
import Charts

struct CoinChart: View {
    @State var date : Date?
    @State var price = 0.0
    @State var showGuideLine = false
    var data : [DailyCoinData]
    var VM : CoinDetailsVM
    
    var chartDetails : DailyCoinData? {
        guard let date else {return nil}
        guard let chartData = VM.selectedDetailedCoinChartData else {return nil}
       return  chartData.first { Calendar.current.compare(date, to: $0.date, toGranularity: .day) == .orderedSame ? true : false}
        
    }
    
    var chartDay : String? {
        guard let date else {return nil}
        guard let chartData = VM.selectedDetailedCoinChartData else {return nil}

        guard let foundDate = chartData.first (where: { Calendar.current.compare(date, to: $0.date, toGranularity: .day) == .orderedSame ? true : false})else{return nil}
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US") // Set locale to get English day names
        formatter.dateFormat = "EEEE" // Full day name (e.g., "Wednesday")

        return formatter.string(from: foundDate.date)
    }
    
    var body: some View {
        
        chart
        .chartXSelection(value: $date)
        .onChange(of: date, { oldValue, newValue in
            showGuideLine = newValue == nil ? false : true
        })
            .chartXAxis{
                AxisMarks(values: .stride(by: .day) ) { _ in
                    AxisTick(stroke:StrokeStyle(lineWidth:1.0 ,dash: [0]))
                    AxisValueLabel(format: .dateTime.month().day())
                }
            }
            .chartYAxis{
                AxisMarks(stroke:StrokeStyle(lineWidth: 2.5))
            }
            .chartYScale(domain: [minPricePoint(data: data) , maxPricePoint(data: data) ])
        
    }
    
    
    var chart : some View {
        Chart(data) {
            LineMark(x: .value("Day", $0.date), y: .value("Price", $0.price))
               
               
            if let test = chartDetails?.date , showGuideLine{
                
                RuleMark(x:.value("selection", test)).annotation(position: .leading, overflowResolution: .init(x:.fit(to: .chart), y:.disabled))
                {
                    annotationView
                }
                    
            }
            
        }
    }
    
    var annotationView : some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10.0 ).fill(VM.selectedDetailedCoin?.marketData.priceChangePercentage24H ?? -1 > 0 ?  .greenApp : .redApp).opacity(0.2)
               
            VStack{
                Text("Price:\(chartDetails?.price.formatToString(maxDecimal: 2, minDecimal: 2) ?? "N/A")")
                    .foregroundStyle(.white)
                Text("Day: \(chartDay ?? "N/A")")
                    .foregroundStyle(.white)
            }.padding()
            
        }
    }
    func maxPricePoint(data:[DailyCoinData]) -> Double {
       
        if let price = data.max(by: { $0.price < $1.price })?.price{
            switch price {
                
            case 100_000...:
               
                return price + 1000
                
            case 10_000...:
                
                return price + 100
            case 1_000...:
                
                return price + 50
            case 100...:
                return price + 10

            default:
                return price + 1
            }
        }
        return .infinity
    }
    
    
    func minPricePoint(data:[DailyCoinData])-> Double{
        if let price = data.min(by: { $0.price < $1.price })?.price{
            switch price {
                
            case 100_000...:
               
                return price - 1000
                
            case 10_000...:
                
                return price - 100
            case 1_000...:
                
                return price - 50
            case 100...:
                return price - 10

            default:
                return price - 1
            }
            
            
            
            
        }
        return 0
    }
    
}

//#Preview {
//    CoinChart(data: [DailyCoinData(price: 100_000, date: Date.now)
//    ,DailyCoinData(price: 101_000, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
//        DailyCoinData(price: 101_000, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!),
//                     DailyCoinData(price: 102_000, date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!),
//                     DailyCoinData(price: 103_000, date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!),   DailyCoinData(price: 104_000, date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!),
//                     DailyCoinData(price: 101_000, date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!)
//                     
//                    ]
//              , VM: CoinDetailsVM())
//}
