//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/28/25.
//

import SwiftUI

struct CoinImageView: View {
    @State var vm : CoinImageVM
    
    init(url:String, name:String) {
        vm = CoinImageVM(url: url, coinName: name)
    }
    
    var body: some View {
        if let image = vm.image {
            Image(uiImage: image)
                .resizable(resizingMode:.stretch)
        }
        else{
            ProgressView()
        }
    }
}

//#Preview {
//    Circle().frame(width: 60, height: 60) .overlay {
//        CoinImageView(url: PreviewProvider.instance.coin.image, name: PreviewProvider.instance.coin.name)
//    }
//       
// 
//}
