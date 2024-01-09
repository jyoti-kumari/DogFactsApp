//
//  DogFactsRemoteRepository.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

import Foundation
import PromiseKit

final internal class DogFactsRemoteRepository: DogFactsRepository {
    
    private let apiService: ServiceProtocol
    private let api: DogFactsAPI
    
    internal init(apiService: ServiceProtocol, api: DogFactsAPI) {
        self.apiService = apiService
        self.api = api
    }
    
    func getRandomFact() -> Promise<DogFactData> {
        return Promise { seal in
            self.apiService.request(getRequest(), responseType: DogFactDTO.self)
                .done { response in
                    seal.fulfill(response.toData)
                }
                .catch { error in
                    seal.reject(error)
                }
        }
    }
    
    fileprivate func getRequest() -> BaseRequest {
        let dogFactsRequest = BaseRequest()
        dogFactsRequest.requestQueryParam = "country=in"
        dogFactsRequest.requestURL = api.factsURL.absoluteString
        return dogFactsRequest
    }
    
    private static func parse<T: Decodable>(type: T.Type, data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

extension DogFactDTO {
    var toData: DogFactData {
        return DogFactData(
            factMessage: facts.reduce(into: "", { $0.append(contentsOf: $1) }))
    }
}
