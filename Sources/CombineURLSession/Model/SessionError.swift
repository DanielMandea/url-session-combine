//
//  SessionError.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation

enum SessionError: Error, Identifiable {
    var id: String { self.localizedDescription }
    case unknown
    case decode
    case network(error: URLError)
    case text(error: TextError)
    case generic(error: Error)
    
    var errorDescription: String {
        switch self {
        case .unknown: return "Unknown error"
        case .decode: return "Unknown decoding error"
        case .network(let error): return error.localizedDescription
        case .text(let error): return error.error ?? "Unknown"
        case .generic(let error): return error.localizedDescription
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .unknown: return "Unknown error"
        case .decode: return "Unknown decoding error"
        case .network(let error): return error.localizedDescription
        case .text(let error): return error.error ?? "Unknown"
        case .generic(let error): return error.localizedDescription
        }
    }
}
