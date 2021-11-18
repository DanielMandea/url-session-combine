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
    case generic(error: Error)
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .decode:
            return "Decoding Error"
        case .generic(let error):
            return "Generic Error" + error.localizedDescription
        }
    }
}
