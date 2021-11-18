//
//  File.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation
import Combine

public protocol RestService {
    @available(iOS 13.0, *)
    func get<T: Codable>(from url: URL, headers: [String: String], decoder: JSONDecoder) -> AnyPublisher<T, Error>
    
    @available(iOS 13.0, *)
    func post<T: Codable, M: Codable>(to url: URL, body: M, headers: [String: String], decoder: JSONDecoder, encoder: JSONEncoder) -> AnyPublisher<T, Error>
    
    @available(iOS 13.0, *)
    func put<T: Codable, M: Codable>(to url: URL, body: M, headers: [String: String], decoder: JSONDecoder, encoder: JSONEncoder) -> AnyPublisher<T, Error>
    
    @available(iOS 13.0, *)
    func delete(for url: URL, headers: [String: String]) -> AnyPublisher<Bool, Error>
    
    @available(iOS 14.0, *)
    func getCachedData<T: Codable>(for url: URL, headers: [String: String], decoder: JSONDecoder, useCache: Bool) -> AnyPublisher<T, Error>
    
    @available(iOS 13.0, *)
    func task<T: Codable>(for urlRequest: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, Error>
}
