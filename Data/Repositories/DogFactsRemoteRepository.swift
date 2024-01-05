//
//  DogFactsRemoteRepository.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

import Foundation
import PromiseKit

final internal class DogFactsRemoteRepository: DogFactsRepository {
    
    private let httpClient: HTTPClient
    private let api: DogFactsAPI
    
    internal init(httpClient: HTTPClient, api: DogFactsAPI) {
        self.httpClient = httpClient
        self.api = api
    }
    
    func getRandomFact() -> Promise<DogFactData> {
        return Promise { seal in
            self.httpClient.request(getRequest(), responseType: DogFactDTO.self)
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
