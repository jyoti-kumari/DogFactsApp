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
        return dogFactsVC
    }
    
}
