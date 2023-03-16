//
//  CoinImageView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import SwiftUI

struct CoinImageView: View {
    
    @ObservedObject var vm: CoinImageViewModel
//    iOS 14.0 or newer
//    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        vm = CoinImageViewModel(coin: coin)
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    Text("loading...")
                        .foregroundColor(Color.secondary)
                }
            } else {
                Image(systemName: "questionmake")
                    .foregroundColor(Color.secondary)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
