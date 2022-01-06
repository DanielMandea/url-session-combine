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
    case generic(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .unknown: return "Unknown error"
        case .generic(let error): return error.localizedDescription
        }
    }
}
