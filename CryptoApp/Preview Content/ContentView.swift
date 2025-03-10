//
//  ContentView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var VM : HomeVM
    
    var body: some View {
        
        ZStack {
            Text("hit me")
                .onTapGesture {
                    VM.updatePortfolioCoinHolding(by: 8 )
                }
            
        }.ignoresSafeArea()
    }
}

#Preview {

    

    ContentView(VM: HomeVM(swiftDataManager: SwiftDataManager.shared))
       
}
