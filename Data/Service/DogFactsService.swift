//
//  DogFactsService.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 10/01/24.
//

import Foundation
import PromiseKit


class DogFactsService {
    
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
}
