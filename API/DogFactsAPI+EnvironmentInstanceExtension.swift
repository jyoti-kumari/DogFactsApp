//
//  DogFactsAPI+EnvironmentInstanceExtension.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 03/01/24.
//

struct DogFactsEnvironment: Environment {
    let baseURL: String = URLConstants.baseURL
}

extension DogFactsAPI {
    static var dev: Self {
        DogFactsAPI(environment: DogFactsEnvironment())
    }
}
