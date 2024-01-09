//
//  DogFactsViewModel.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 03/01/24.
//

import Foundation
import PromiseKit

protocol DogFactsViewModelProtocol {
    var factMessage:Observable<String> { get }
    var errorMessage: Observable<String> { get }
    func getTitle() -> String
    func fetchRandomFact()
    func onUserInput()
}

final class DogFactsViewModel: DogFactsViewModelProtocol {
    
    // MARK: - Dependencies
    
    let dogFactsUseCase: GetDogFactsUseCaseProtocol
    
    // MARK: - Properties
    
    var factMessage:Observable<String> = Observable("")
    var errorMessage: Observable<String> = Observable("")
    
    // MARK: - Initialization
    
    init(dogFactsUseCase: GetDogFactsUseCaseProtocol) {
        self.dogFactsUseCase = dogFactsUseCase
    }
    
    // MARK: - Public Methods
    
    func getTitle() -> String {
        return NAConstants.title
    }
    
    func fetchRandomFact() {
        dogFactsUseCase.execute()
            .done { [weak self] data in
                self?.factMessage.value = data.factMessage
            }
            .catch { error in
                self.errorMessage.value = error.localizedDescription
            }
    }
    
    func onUserInput() {
        fetchRandomFact()
    }
}
