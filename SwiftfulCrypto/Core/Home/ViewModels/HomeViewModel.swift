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
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubcribers()
    }
    
    func addSubcribers() {
        dataService.$allCoin
            .sink { [weak self] (result) in
                self?.allCions = result
            }
            .store(in: &cancellables)
    }
}
