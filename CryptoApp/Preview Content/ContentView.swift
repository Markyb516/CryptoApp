//
//  ContentView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/19/25.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @State var animation: Bool = false
    var body: some View {
        VStack {

            // This is the Button
            Button(action: {
                withAnimation(.spring(dampingFraction: 1, blendDuration: 0.5)) {
                    animation.toggle()
                }
            }) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.accentColor)
            }
            ZStack{
                // This condition sends up the View
                if animation {
                    SecondView()
                        .background(.green)
                        .transition(.move(edge: .bottom))
                      
                }
            }.clipped().background(.red)
        }
        .padding()
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .onDisappear{
            print("View gone")
        }
    }
}

#Preview {

    

    ContentView()
       
}
