//
//  SessionHolder.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation

public protocol SessionHolder {
    var session: URLSession { get }
}
