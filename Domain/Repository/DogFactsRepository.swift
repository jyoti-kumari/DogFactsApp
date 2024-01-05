//
//  DogFactsRepository.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//
import PromiseKit

protocol DogFactsRepository {
    func getRandomFact() -> Promise<DogFactData>
}
