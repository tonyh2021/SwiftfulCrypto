//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-22.
//

import Foundation
import Combine

final class MarketDataService {
    
    @Published private(set) var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.marketData = result.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
