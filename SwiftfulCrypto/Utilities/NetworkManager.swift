//
//  NetworkManager.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import Foundation
import Combine

final class NetworkManager {
    
    enum NetworkError: LocalizedError {
        case badServerResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            var description: String?
            switch self {
            case .badServerResponse(url: let url):
                description = "[😰] Bad response from URL: \(url)"
            case .unknown:
                description = "[⚠️] Unknown error occured."
            }
            return description
        }
    }
    
    static var debug: Bool = true
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badServerResponse(url: url)
        }
        if debug {
            print("URL: \(url)")
            print("StatusCode: \(response.statusCode)")
            print("Data Length: \(output.data.count)")
//            do {
//                let json = try JSONSerialization.jsonObject(with: output.data, options: [])
//                print("Data: \(json)")
//            } catch let error {
//                print("Failed to print: \(error.localizedDescription)")
//            }
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
