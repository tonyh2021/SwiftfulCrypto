//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import Foundation
import UIKit
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var coin: CoinModel
    private var imageSubscription: AnyCancellable? = nil
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
//            print("Retrieved image from File Manager!")
        } else {
            downloadCoinImage()
//            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (result) in
                guard let self = self, let downloadedImage = result else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
