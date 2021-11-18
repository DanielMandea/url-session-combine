//
//  File.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation

// MARK: - String Extension

extension String {
    func data() -> Data {
        return self.data(using: .utf8) ?? Data()
    }
}
