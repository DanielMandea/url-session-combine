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
            .mapError {
                SessionError.generic(error: $0)
            }
            .eraseToAnyPublisher()
    }
    
    @available(iOS 13.0, *)
    public func dataTaskPublisher<T: Codable>(for urlRequest: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: urlRequest)
            .receive(on: RunLoop.main)
            .tryMap { output -> Data in
                try URLSession.validate(decoder: decoder, output: output)
            }
            .tryMap {
                try URLSession.decode(decoder: decoder, data: $0)
            }
            .eraseToAnyPublisher()
    }
    
    @available(iOS 13.0, *)
    public func dataTaskPublisher<T: Codable>(for url: URL, decoder: JSONDecoder) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .tryMap { output -> Data in
                try URLSession.validate(decoder: decoder, output: output)
            }
            .tryMap {
                try URLSession.decode(decoder: decoder, data: $0)
            }
            .eraseToAnyPublisher()
    }
    
    @available(iOS 14.0, *)
    public func dataCachePublisher<T: Codable>(for urlRequest: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, Error>? {
        configuration.urlCache?.cachedResponse(for: urlRequest).publisher
            .receive(on: RunLoop.main)
            .tryMap { element -> Data in
                try URLSession.validate(element: element)
            }
            .tryMap {
                try URLSession.decode(decoder: decoder, data: $0)
            }
            .eraseToAnyPublisher()
    }
    
    static func validate(element: CachedURLResponse) throws -> Data {
        // Cheks http response
        guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 300 else { throw SessionError.network(error: URLError(.badServerResponse)) }
        // Cheks we can decode the obj
        return element.data
    }
    
    @available(iOS 13.0, *)
    static func validate(decoder: JSONDecoder, output: URLSession.DataTaskPublisher.Output) throws -> Data {
        // Cheks http response
        guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode < 300 else {
            // Cheks if we can decode the error
            throw try URLSession.decodeError(decoder: decoder, data: output.data)
        }
        // Returns the output
        return output.data
    }
    
    static func decodeError(decoder: JSONDecoder, data: Data) throws -> TextError {
        guard let error = try? decoder.decode(TextError.self, from: data) else {
            // Send generic error
            let errorStr = String(data: data, encoding: .utf8)
            throw SessionError.text(error: TextError(error: errorStr))
        }
        throw SessionError.text(error: error)
    }
    
    static func decode<T: Codable>(decoder: JSONDecoder, data: Data) throws -> T {
        // Cheks we can decode the obj
        guard let value = try? decoder.decode(T.self, from: data) else {
            // Cheks if we can decode the error
            throw try URLSession.decodeError(decoder: decoder, data: data)
        }
        return value
    }
}
