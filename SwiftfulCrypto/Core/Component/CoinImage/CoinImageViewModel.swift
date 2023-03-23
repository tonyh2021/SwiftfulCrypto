//
//  CoinImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import Foundation
import UIKit
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubcribers()
        self.isLoading = true
    }
    
    private func addSubcribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (result) in
                self?.image = result
            }
            .store(in: &cancellables)
    }
}
