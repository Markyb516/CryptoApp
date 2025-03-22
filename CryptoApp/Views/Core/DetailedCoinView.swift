//
//  DetailedCoinView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 3/16/25.
//

import SwiftUI

struct DetailedCoinView: View {
    var coinID : String
    var VM : HomeVM
 
    var body: some View {
        ZStack{
            if let selectedCoin = VM.selectedDetailedCoin{
                Text("\(selectedCoin.description?.en ?? "none workign")")
            }
            else{
                ProgressView()
            }
         
        }
        .task {
            await VM.getCoinDetails(id: coinID)
        }
    }
}

#Preview {
    DetailedCoinView(coinID: "bitcoin", VM: HomeVM(swiftDataManager: SwiftDataManager.shared))
}
