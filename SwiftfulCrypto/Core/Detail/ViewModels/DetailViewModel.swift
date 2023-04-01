//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published private(set) var overviewStatistics: [StatisticModel] = []
    @Published private(set) var additionalStatistics: [StatisticModel] = []
    @Published private(set) var coinDescription: String? = nil
    @Published private(set) var websiteURL: String? = nil
    @Published private(set) var redditURL: String? = nil
    
    @Published private(set) var coin: CoinModel
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubcribers()
    }
    
    func addSubcribers() {
        
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.overviewStatistics = result.overview
                self.additionalStatistics = result.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetail
            .sink { [weak self] detail in
                guard let self = self else { return }
                self.coinDescription = detail?.readableDescription
                self.websiteURL = detail?.links?.homepage?.first
                self.redditURL = detail?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(detailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {

        let overviewArray = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(detailModel: detailModel, coinModel: coinModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "" )
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        return [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
    }
    
    private func createAdditionalArray(detailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h high", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentageChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentageChange2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "" )
        let marketCapPercentageChange2 = coinModel.marketCapChangePercentage24H
        let marketChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentageChange2)
        
        let blockTime = detailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = detailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        return [
            highStat, lowStat, priceChangeStat, marketChangeStat, blockStat, hashingStat
        ]
    }
}
