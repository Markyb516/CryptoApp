//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 2/2/25.
//

import SwiftUI

struct SearchBarView: View {
    @Bindable var VM:HomeVM
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .padding()
            
            TextField("currency search", text:$VM.filterText, prompt: Text("search by name or symbol ")
                    .foregroundStyle(.secondaryText)
            )
            .autocorrectionDisabled()
            .padding(.vertical)
            
            if !VM.filterText.isEmpty{
                Image(systemName: "xmark.circle")
                    .padding()
                    .onTapGesture {
                        VM.filterText = ""
                    }
            }
        }
        .padding(.horizontal)
        .font(.headline)
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.theme.background)
                .shadow(color:.accent.opacity(0.4),radius: 10.0)
        )
        .padding(.bottom)
    }
}

#Preview {
    let test = HomeVM()

    SearchBarView(VM: test)
}
