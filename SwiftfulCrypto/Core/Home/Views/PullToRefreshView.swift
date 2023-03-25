//
//  PullToRefreshView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-23.
//

import SwiftUI


typealias OnTapCallback = (_ coin: CoinModel) -> Void

struct PullToRefreshView: View {
    
    @ObservedObject var vm: HomeViewModel
    
    let onTap: OnTapCallback
    
    var body: some View {
        List {
            ForEach(vm.allCions) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        onTap(coin)
                    }
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct PullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefreshView(vm: dev.homeVM, onTap: { coin in
            print("\(coin.name)")
        })
    }
}
