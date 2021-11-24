//
//  CodableToDictionary.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation
import AnyCodable

struct CodableToDictionary {
    static func transform<T: Codable>(payload: T, encoder: JSONEncoder, decoder: JSONDecoder) throws -> [String: AnyCodable] {
        let data = try encoder.encode(payload)
        return try decoder.decode([String: AnyCodable].self, from: data)
    }
}
