//
//  URLSessionHTTPClientError.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

import Foundation

public enum URLSessionHTTPClientError: Error {
    case invalidURL
    case noData
    case networkError
    case decodingError
}
