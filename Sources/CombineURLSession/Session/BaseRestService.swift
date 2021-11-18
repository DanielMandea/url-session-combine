//
//  BaseRestService.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation

open class BaseRestService: SessionHolder, RestService {
    
    // MARK: - SessionHolder
    
    public var session: URLSession { URLSession.shared }
}
