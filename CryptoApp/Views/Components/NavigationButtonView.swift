//
//  NavigationButtonView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/20/25.
//

import SwiftUI

struct NavigationButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    var imageName : String
    var body: some View {
    
            Image(systemName: imageName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width : 50.0, height: 50.0)
            
            .background {
                Circle()
                    .foregroundStyle(Color.theme.background)
                    
                    .shadow(color: colorScheme == .dark ? Color.theme.accent.opacity(0.6):Color.theme.accent.opacity(0.3) ,radius: 10.0)
                    
            }
            
            
        
    }
}

#Preview {
    NavigationButtonView(imageName: "plus")
}
