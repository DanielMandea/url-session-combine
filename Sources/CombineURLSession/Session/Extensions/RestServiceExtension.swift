//
//  RestServiceExtension.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation
import Combine

extension RestService where Self: SessionHolder {
    @available(iOS 13.0, *)
    public func get<T: Codable>(from url: URL, headers: [String: String] = ["Content-Type":"application/json"], decoder: JSONDecoder) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: URLRequest.empty(for: url, method: .GET, headers: headers), decoder: decoder)
    }
    
    @available(iOS 13.0, *)
    public func post<T: Codable, M: Codable>(to url: URL, body: M, headers: [String: String] = ["Content-Type":"application/json"], decoder: JSONDecoder, encoder: JSONEncoder) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: URLRequest.request(for:url, method: .POST, headers: headers, httpBody: body, encoder: encoder), decoder: decoder)
    }
    
    @available(iOS 13.0, *)
    public func put<T: Codable, M: Codable>(to url: URL, body: M, headers: [String: String] = ["Content-Type":"application/json"], decoder: JSONDecoder, encoder: JSONEncoder) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: URLRequest.request(for:url, method: .PUT, headers: headers, httpBody: body, encoder: encoder), decoder: decoder)
    }
    
    @available(iOS 13.0, *)
    public func delete(for url: URL, headers: [String: String] = ["Content-Type":"application/json"]) -> AnyPublisher<Bool, Error> {
        session.boolTaskPublisher(for: URLRequest.empty(for: url, method: .DELETE, headers: headers))
    }
    
    @available(iOS 14.0, *)
    public func getCachedData<T: Codable>(for url: URL, headers: [String: String] = ["Content-Type":"application/json"], decoder: JSONDecoder, useCache: Bool) -> AnyPublisher<T, Error> {
        session.dataCachePublisher(for: URLRequest.empty(for: url, method: .GET, headers: headers), decoder: decoder) ?? session.dataTaskPublisher(for: URLRequest.empty(for: url, method: .GET, headers: headers), decoder: decoder)
    }
    
    @available(iOS 13.0, *)
    public func task<T: Codable>(for urlRequest: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, Error>  {
        session.dataTaskPublisher(for: urlRequest, decoder: decoder)
    }
    
    @available(iOS 13.0, *)
    public func bool(for urlRequest: URLRequest) -> AnyPublisher<Bool, Error>  {
        session.boolTaskPublisher(for: urlRequest)
    }
}
