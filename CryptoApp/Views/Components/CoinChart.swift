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
        
    }
    
    
    var chart : some View {
        Chart(data) {
            LineMark(x: .value("Day", $0.date), y: .value("Price", $0.price))
                .foregroundStyle(data[0].price > data[1].price ? .greenApp : .redApp )
               
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
            RoundedRectangle(cornerRadius: 10.0 ).fill(data[0].price > data[1].price ? .greenApp : .redApp).opacity(0.2)
               
            VStack{
                Text("Price:\(chartDetails?.price.formatToString(maxDecimal: 2, minDecimal: 2) ?? "N/A")")
                    .foregroundStyle(.white)
                Text("Day: \(chartDay ?? "N/A")")
                    .foregroundStyle(.white)
            }.padding()
            
        }
    }
}

//#Preview {
//    CoinChart(data: <#[DailyCoinData]#>, VM: <#CoinDetailsVM#>)
//}
