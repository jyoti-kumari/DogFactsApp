//
//  DogFactsAPI+MappingExtension.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

import Foundation

extension DogFactsAPI {
    var factsURL: URL { URL(string: URLConstants.baseURL)! }
    var moreFactsURL: URL { getURL(path: URLConstants.factsURLKey) }
}

fileprivate extension DogFactsAPI {
    func getURL(path: String) ->  URL {
        URL(string: "\(environment.baseURL)/\(path)")!
    }
}
