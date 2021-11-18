//
//  CodableToDictionary.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation

struct CodableToDictionary {
    static func transform<T: Codable>(payload: T, encoder: JSONEncoder, decoder: JSONDecoder) throws -> [String:String] {
        let data = try encoder.encode(payload)
        return try decoder.decode([String: String].self, from: data)
    }

}
