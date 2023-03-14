//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCions: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubcribers()
    }
    
    func addSubcribers() {
        dataService.$allCoin
            .sink { [weak self] (returnedCoins) in
                self?.allCions = returnedCoins
            }
            .store(in: &cancellables)
    }
}
