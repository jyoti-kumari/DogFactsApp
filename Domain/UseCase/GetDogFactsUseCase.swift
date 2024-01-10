//
//  GetDogFactsUseCase.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 03/01/24.
//

import Foundation
import PromiseKit

protocol GetDogFactsUseCaseProtocol {
    func execute() -> Promise<DogFactData>
}

class GetDogFactsUseCase: GetDogFactsUseCaseProtocol {
    private let factsRepository: DogFactsRepositoryProtocol
    
    init(factsRepository: DogFactsRepositoryProtocol) {
        self.factsRepository = factsRepository
    }
    
    func execute() -> Promise<DogFactData> {
        return factsRepository.getRandomFact()
    }
}
