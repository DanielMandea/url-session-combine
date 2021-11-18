//
//  File.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation


extension URLRequest {
    
    static func empty(for url: URL, method: HttpMethod, headers: [String: String]? = nil) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
    
    static func request<T: Codable>(for url: URL, method: HttpMethod, headers: [String: String]? = nil , httpBody: T? = nil, encoder: JSONEncoder) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        if let bodyValue = httpBody {
            urlRequest.httpBody = try? encoder.encode(bodyValue)
        }
        return urlRequest
    }
    
    static func multipart<T: Codable>(for url: URL, method: HttpMethod = .POST, headers: [String: String]? = nil, payload: T? = nil, multiparts: [Multipart], encoder: JSONEncoder, decoder: JSONDecoder) -> URLRequest {
        URLRequest(multipartFormData: { (formData) in
            if let payloadData = try? CodableToDictionary.transform(payload: payload, encoder: encoder, decoder: decoder) {
                for key in payloadData.keys {
                    formData.append(value: payloadData[key] ?? "Unknown", name: key)
                }
            }
            
            for multipart in multiparts {
                formData.append(file: multipart.data, name: multipart.key, fileName: multipart.fileName, mimeType: multipart.mimeType.rawValue)
            }
            
        }, url: url, method: method, headers: headers ?? [:])
    }
}
