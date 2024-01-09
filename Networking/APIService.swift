//
//  APIService.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

import Foundation
import PromiseKit

protocol ServiceProtocol {
   func request<T: Decodable>(_ request: RequestProtocol, responseType: T.Type) -> Promise<T>
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add more HTTP methods as needed
}

protocol RequestProtocol {
    var httpMethod: HTTPMethod {get set}
    var requestURL: String {get}
    var requestParams: [String: Any]? {get}
    var additionalHeaders: [String: String]? {get}
    var requestQueryParam: String {get set}
    var apiKey: String {get set}

}

class BaseRequest: RequestProtocol {
    var httpMethod: HTTPMethod = .get
    var requestURL: String = ""
    var requestParams: [String: Any]?
    var additionalHeaders: [String: String]?
    var requestQueryParam: String = ""
    var apiKey: String = ""

    init() {
        self.additionalHeaders = [URLConstants.additionalHeadersKey : URLConstants.additionalHeaders]
        if let apiKey = Bundle.main.infoDictionary?[URLConstants.apiKey] as? String {
            self.apiKey = apiKey
        }
    }
}
