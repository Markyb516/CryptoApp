//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/19/25.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    @State private var homeVM = HomeVM()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .environment(homeVM)
            }
        }
    }
}
