//
//  MultipartFormData.swift
//  
//
//  Created by Daniel Mandea on 18.11.2021.
//

import Foundation

public class MultipartFormData {
    
    // MARK: - Public
    
    public var request: URLRequest
    
    // MARK: - Init
    
    public init(request: URLRequest) {
        self.request = request
    }
    
    // MARK: - Internal 
    
    func append(value: String, name: String) {
        request.httpBody?.append("--\(boundary)\r\n".data())
        request.httpBody?.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data())
        request.httpBody?.append("\(value)\r\n".data())
    }
    
    func append(file: Data, name: String, fileName: String, mimeType: String) {
        request.httpBody?.append("--\(boundary)\r\n".data())
        request.httpBody?.append("Content-Disposition: form-data; name=\"\(name)\";".data())
        request.httpBody?.append("filename=\"\(fileName)\"\r\n".data())
        request.httpBody?.append("Content-Type: \(mimeType)\r\n\r\n".data())
        request.httpBody?.append(file)
        request.httpBody?.append("\r\n".data())
    }
    
    func finalize() {
        request.httpBody?.append("--\(boundary)--\r\n".data())
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    }
    
    // MARK: - Private
    
    private lazy var boundary: String = {
       return String(format: "%08X%08X", arc4random(), arc4random())
    }()
}
