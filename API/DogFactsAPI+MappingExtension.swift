//
//  DogFactsAPI+MappingExtension.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

import Foundation

extension DogFactsAPI {
    var factsURL: URL { getURL(path: "facts") }
}

fileprivate extension DogFactsAPI {
    func getURL(path: String) ->  URL {
        URL(string: "\(environment.baseURL)/\(path)")!
    }
}
