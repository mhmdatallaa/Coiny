//
//  NetworkManager.swift
//  Coiny
//
//  Created by Mohamed Atallah on 02/08/2025.
//

import Foundation
import Combine

final class NetworkManager {
    
    // MARK: Networking errors
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url): "Bad response from URL: \(url)."
            case .unknown: "Unknown error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: Handle URL Response
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            Logger.shared.log(NetworkingError.badURLResponse(url: url).localizedDescription, level: .error, toFile: true)
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    // MARK: Handle Completion
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case .failure(let error):
            Logger.shared.log("\(error.localizedDescription)", level: .error)
        }
    }
}
