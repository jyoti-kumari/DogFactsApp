//
//  DogFactsConstants.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 04/01/24.
//

import Foundation

struct StringConstant {
    static let title: String = "Dog Facts"
    static let factsLoadFail: String = "Facts Loading Failed"
    static let defaultErrorMessage: String = "System Error"
}

struct URLConstants {
    static let baseURL = "https://meowfacts.herokuapp.com"
    // static let baseURL = "https://dog-api.kinduff.com/api"
    static let factsURLKey = "facts"
    static let additionalHeadersKey = "Content-Type"
    static let additionalHeaders = "application/json"
    static let apiKey = "ApiKey"
}
