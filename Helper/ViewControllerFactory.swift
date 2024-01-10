//
//  ViewControllerFactory.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 04/01/24.
//

import Foundation

class ViewControllerFactory {
    
    static func createDogFactsViewController() -> DogFactsViewController {
       let dogFactsVC: DogFactsViewController = DogFactsViewController.instantiateFromStoryboard(named: .main)
        let dogService = DogFactsService(apiService: APIManager(), api: .dev)
        let repository = GetDogFactsUseCase(factsRepository: DogFactsRepository(apiService: dogService))
        dogFactsVC.viewModelProtocol = DogFactsViewModel(dogFactsUseCase: repository)
        dogFactsVC.viewModelProtocol.outputDelegate = dogFactsVC
        return dogFactsVC
    }
    
}
