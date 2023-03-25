//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoin: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.allCoin = result
                self?.coinSubscription?.cancel()
            })
    }
}
