//
//  TextError.swift
//  
//
//  Created by Daniel Mandea on 11.03.2022.
//

import Foundation

public struct TextError: Error, Codable {
    public var error: String?
}
