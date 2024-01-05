//
//  URLSessionProtocol.swift
//  DogsFactTests
//
//  Created by Jyoti Kumari on 04/01/24.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}
extension URLSessionDataTask: URLSessionDataTaskProtocol { }

typealias DataCompletion = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(_ url: URL, completion: @escaping DataCompletion)
    -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTaskWithURL(_ url: URL, completion completionHandler: @escaping DataCompletion)
    -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}
