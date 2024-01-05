//
//  DogFactsViewModelTest.swift
//  DogsFactTests
//
//  Created by Jyoti Kumari on 04/01/24.
//

import XCTest
import PromiseKit
@testable import DogsFact

class DogFactsViewModelTest: XCTestCase {
    var viewModel: DogFactsViewModel!
    
    class MockGetDogFactUseCase: GetDogFactsUseCaseProtocol {
        var apiResponse: DogFactData?
        var error: Error?
        
        func execute() -> Promise<DogFactData> {
            if let error = error {
                return Promise(error: error)
            }
            guard let response = apiResponse else { return Promise(error: URLSessionHTTPClientError.noData) }
            return Promise.value(response)
        }
    }
    
    override func setUp() {
        viewModel = DogFactsViewModel(dogFactsUseCase: MockGetDogFactUseCase(), onSuccess: { [weak self] in self?.onSuccess(factMessage: $0) }, onError: { [weak self] in self?.onError(errorMessage: $0) })
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func onSuccess(factMessage: String) {
        XCTAssertEqual(factMessage, "Puppies then take a year or more to gain the other half of their body weight.")
    }
    
    func onError(errorMessage: String) {
        XCTAssertNotNil(errorMessage)
    }
    
    // Test fetching facts successfully
    func testGetDogFactSuccess() {
        // Given
        let mockResponse = MockResponseManager.loadMockResponse(ofType: DogFactDTO.self, from: "DogFact")
        
        if let useCase = viewModel.dogFactsUseCase as? MockGetDogFactUseCase {
            useCase.apiResponse = mockResponse?.toData
        }
        viewModel.fetchRandomFact()
    }
    
    // Test fetching facts with an error
    func testGetDogFactError() {
        // Given
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        
        if let useCase = viewModel.dogFactsUseCase as? MockGetDogFactUseCase {
            useCase.error = mockError
        }
        viewModel.fetchRandomFact()
    }

}
