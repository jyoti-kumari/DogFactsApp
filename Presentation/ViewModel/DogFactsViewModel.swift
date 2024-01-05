//
//  DogFactsViewModel.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 03/01/24.
//

import Foundation
import PromiseKit

final class DogFactsViewModel {
    
    // MARK: - Dependencies
    
    let dogFactsUseCase: GetDogFactsUseCaseProtocol
    
    // MARK: - Properties
    
    private let onSuccess: (_ factValue: String) -> Void
    private let onError: (_ errorMessage: String) -> Void
    
    // MARK: - Initialization
    
    init(dogFactsUseCase: GetDogFactsUseCaseProtocol, onSuccess: @escaping (_: String) -> Void, onError: @escaping (_: String) -> Void) {
        self.dogFactsUseCase = dogFactsUseCase
        self.onSuccess = onSuccess
        self.onError = onError
    }
    
    // MARK: - Public Methods
    
    func fetchRandomFact() {
        dogFactsUseCase.execute()
            .done { [weak self] data in
                self?.onSuccess(data.factMessage)
            }
            .catch { error in
                self.onError(error.localizedDescription)
            }
    }
}

extension DogFactsViewModel {
    enum UserInput {
        case fetchFactClicked
    }
    
    func onUserInput(_ input: UserInput) {
        switch input {
        case .fetchFactClicked:
            fetchRandomFact()
        }
    }
    
}
