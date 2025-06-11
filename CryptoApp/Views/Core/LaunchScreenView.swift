//
//  LaunchScreenView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 4/25/25.
//

import SwiftUI

struct LaunchScreenView: View {
    let loadingTittle = ["L","o","a","d","i","n","g",".",".","."]
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    @State var counter = 0
    @State var loops = 0
    @Binding var showApp : Bool
    var body: some View {
        ZStack{
            Image("logo").resizable().ignoresSafeArea()
            HStack{
                ForEach(loadingTittle.indices, id: \.self) { index in
                    Text(loadingTittle[index])
                        .foregroundStyle(.launchAccent)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .offset(y: Int(index) == counter ? 334 : 350)
                      
                }
        
            }
            
        }.onReceive(timer) { _ in
            
            withAnimation(.smooth(duration: 1)) {
                counter += 1
                
                
                if counter == loadingTittle.count {
                    counter = 0
                    loops += 1
                }
                if loops == 2 {
                    showApp = true
                }
            }
        }
        .transition( .move(edge: .leading))

    }
}
//
//#Preview {
//    LaunchScreenView()
//}
