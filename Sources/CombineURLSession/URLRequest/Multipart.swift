//
//  Multipart.swift
//  Thrust
//
//  Created by Daniel Mandea on 10.11.2021.
//

import Foundation

public struct Multipart: Codable {
    public var key: String
    public var data: Data
    public var mimeType: MimeType
    public var fileName: String
}
