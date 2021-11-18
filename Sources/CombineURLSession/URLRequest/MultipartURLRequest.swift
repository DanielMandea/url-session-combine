//
//  MultipartURLRequest.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation
import MobileCoreServices

extension URLRequest {
    
    public init(multipartFormData constructingBlock: @escaping (_ formData: MultipartFormData) -> Void,
         url: URL,
         method: HttpMethod = .POST,
         headers: [String: String] = [:]) {
        self.init(url: url)
        self.httpMethod = method.rawValue.uppercased()
        self.httpBody = Data()
        let formData = MultipartFormData(request: self)
        constructingBlock(formData)
        formData.finalize()
        self = formData.request
        for (k,v) in headers {
            self.addValue(v, forHTTPHeaderField: k)
        }
    }
}
