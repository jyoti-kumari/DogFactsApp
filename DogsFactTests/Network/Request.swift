//
//  Request.swift
//  DogsFactTests
//
//  Created by Jyoti Kumari on 09/01/24.
//

import Foundation
@testable import DogsFact

struct MockRequest: RequestProtocol {
    var requestQueryParam: String = ""
    var apiKey: String = ""
    var httpMethod: DogsFact.HTTPMethod = .get
    var requestParams: [String: Any]?
    var additionalHeaders: [String: String]?
    let requestURL: String = ""
}

struct DogFactsTestEnvironment: Environment {
    let baseURL: String = "https://test.com"
}
