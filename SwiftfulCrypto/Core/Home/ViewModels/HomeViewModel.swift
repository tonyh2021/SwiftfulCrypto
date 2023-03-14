//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCions: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCions.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
    
    func downloadData(<#parameters#>) -> <#return type#> {
        <#function body#>
    }
}
