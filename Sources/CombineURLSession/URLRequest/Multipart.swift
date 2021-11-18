//
//  Multipart.swift
//  Thrust
//
//  Created by Daniel Mandea on 10.11.2021.
//

import Foundation

public struct Multipart: Codable {
    
    // MARK: - Public Variables
    
    public var key: String
    public var data: Data
    public var mimeType: MimeType
    public var fileName: String
    
    // MARK: - Public Init
    
    public init(key: String, data: Data, mimeType: MimeType, fileName: String) {
        self.key = key
        self.data = data
        self.mimeType = mimeType
        self.fileName = fileName
    }
}
