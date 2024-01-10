//
//  DogFactsRepository.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

import Foundation
import PromiseKit

protocol DogFactsRepositoryProtocol {
    func getRandomFact() -> Promise<DogFactData>
}

final internal class DogFactsRepository: DogFactsRepositoryProtocol {
    
    private let apiService: DogFactsService
    
    internal init(apiService: DogFactsService) {
        self.apiService = apiService
    }
    
    func getRandomFact() -> Promise<DogFactData> {
        return apiService.getRandomFact()
    }
}
