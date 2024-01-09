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
        let repository = GetDogFactsUseCase(factsRepository: DogFactsRemoteRepository(apiService: APIManager(), api: .dev))
        dogFactsVC.viewModelProtocol = DogFactsViewModel(dogFactsUseCase: repository)
        return dogFactsVC
    }
    
}
