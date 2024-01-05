//
//  DogFactsAPI+EnvironmentInstanceExtension.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 03/01/24.
//

struct DogFactsEnvironment: Environment {
    let baseURL: String = "https://dog-api.kinduff.com/api"
}

extension DogFactsAPI {
    static var dev: Self {
        DogFactsAPI(environment: DogFactsEnvironment())
    }
}
