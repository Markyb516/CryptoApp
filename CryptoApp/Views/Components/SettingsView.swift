//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 4/21/25.
//

import SwiftUI
struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            List {
                coingeikoSection
                
                developerSection
                
                applicationSection
                
                
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                }
            }
        }
    }
    
    var applicationSection : some View {
        
        Section("Application"){
            
            Text("Terms of Service")
                .foregroundStyle(.blue)
                .fontWeight(.semibold)
            
            Text("Privacy Policy")
                .foregroundStyle(.blue)
                .fontWeight(.semibold)
            
            Text("Company Website")
                .foregroundStyle(.blue)
                .fontWeight(.semibold)
            
            Text("Learn More")
                .foregroundStyle(.blue)
                .fontWeight(.semibold)
        }
    }
    
    var developerSection : some View {
        Section("Developer") {
            VStack(alignment:.leading){
                Image("logo")
                    .resizable()
                
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 34.0))
                Text("This app was developed by Markus Buchanan. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading and data persistance")
                
                Text("Visit Website 🥳")
                    .foregroundStyle(.blue)
                    .fontWeight(.semibold)
                    .padding(.top)
            }
        }
        
    }
    
    var coingeikoSection : some View {
        Section("Coingecko"){
            VStack(alignment: .leading){
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed")
                
                Text("Visit CoinGecko🥳")
                    .foregroundStyle(.blue)
                    .fontWeight(.semibold)
                    .padding(.top)
                
            }
        }
    }
}




#Preview {
 
        SettingsView()
    
}
