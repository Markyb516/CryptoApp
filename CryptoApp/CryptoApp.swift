//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/19/25.
//

import SwiftUI
import SwiftData

@main
struct CryptoApp: App {
    @State private var homeVM : HomeVM
    let modelContainer : ModelContainer
    @State var showApp = false
    
    init() {
        let cointainer = try! ModelContainer(for: PortfolioModel.self)
        self._homeVM = State(initialValue: HomeVM(swiftDataManager: SwiftDataManager.shared))
        self.modelContainer = cointainer
    }
    
    var body: some Scene {
        
        WindowGroup {
            ZStack{
                NavigationStack{
                    HomeView()
                        .environment(homeVM)
                }
                ZStack{
                    if !showApp{
                        
                        LaunchScreenView(showApp: $showApp)
                    }
                }
            }
        }
    }
}
