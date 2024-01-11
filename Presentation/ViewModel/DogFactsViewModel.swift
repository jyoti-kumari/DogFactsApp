//
//  DogFactsViewModel.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 03/01/24.
//

import Foundation
import PromiseKit

protocol DogFactsViewModelProtocol {
    var factMessage:String { get }
    var getTitle: String { get }
    func fetchRandomFact()
    func onUserInput()
    var outputDelegate: DogFactsViewModelOutput? { get set }
}

protocol DogFactsViewModelOutput: AnyObject {
    func handleSuccess()
    func handleFailure(_ message: String)
}


final class DogFactsViewModel: DogFactsViewModelProtocol {
    weak var outputDelegate: DogFactsViewModelOutput?
    
    
    // MARK: - Dependencies
    
    let dogFactsUseCase: GetDogFactsUseCaseProtocol
    
    // MARK: - Properties
    
    var factMessage:String = ""
    var errorMessage: String = ""
    var getTitle: String { StringConstant.title }
    
    // MARK: - Initialization
    
    init(dogFactsUseCase: GetDogFactsUseCaseProtocol) {
        self.dogFactsUseCase = dogFactsUseCase
    }
    
    // MARK: - Public Methods
    
    func fetchRandomFact() {
        dogFactsUseCase.execute()
            .done { [weak self] data in
                self?.factMessage = data.factMessage
                self?.outputDelegate?.handleSuccess()
            }
            .catch { error in
                self.errorMessage = error.localizedDescription
                self.outputDelegate?.handleFailure(self.errorMessage)
            }
    }
    
    func onUserInput() {
        fetchRandomFact()
    }
}
