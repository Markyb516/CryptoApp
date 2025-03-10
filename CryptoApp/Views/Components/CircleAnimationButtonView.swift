//
//  CircleAnimationButton.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/20/25.
//

import SwiftUI

struct CircleAnimationButtonView: View {
    @Binding var animate : Bool
    
    var body: some View {
            Circle()
                .stroke(lineWidth: animate ? 10.0 : 0)
                .foregroundStyle(animate ? Color.theme.background : Color.theme.accent)
                .animation(animate ? .smooth(duration: 0.6) : .none, value: animate)
    }
}

//#Preview {
//    @Previewable @State var animate = false
//    CircleAnimationButtonView(animate: $animate)
//        .onTapGesture {
//            animate.toggle()
//        }
//}
