//
//  URLSessionExtension.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation
import Combine

extension URLSession {
    @available(iOS 13.0, *)
    public func boolTaskPublisher(for urlRequest: URLRequest) -> AnyPublisher<Bool, Error> {
       dataTaskPublisher(for: urlRequest)
            .receive(on: RunLoop.main)
            .tryMap() { element -> Bool in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 300 else { throw URLError(.badServerResponse)}
                return true
            }
            .mapError { SessionError.generic(error: $0) }
            .eraseToAnyPublisher()
    }
    
    @available(iOS 13.0, *)
    public func dataTaskPublisher<T: Codable>(for urlRequest: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: urlRequest)
            .receive(on: RunLoop.main)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 300 else {throw URLError(.badServerResponse) }
                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { SessionError.generic(error: $0) }
            .eraseToAnyPublisher()
    }
    
    @available(iOS 13.0, *)
    public func dataTaskPublisher<T: Codable>(for url: URL, decoder: JSONDecoder) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { SessionError.generic(error: $0) }
            .eraseToAnyPublisher()
    }
    
    @available(iOS 14.0, *)
    public func dataCachePublisher<T: Codable>(for urlRequest: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, Error>? {
        configuration.urlCache?.cachedResponse(for: urlRequest).publisher
            .receive(on: RunLoop.main)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { SessionError.generic(error: $0) }
            .eraseToAnyPublisher()
    }
}
