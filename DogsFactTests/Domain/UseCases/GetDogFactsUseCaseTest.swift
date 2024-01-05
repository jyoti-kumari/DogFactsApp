//
//  GetDogFactsUseCaseTest.swift
//  DogsFactTests
//
//  Created by Jyoti Kumari on 04/01/24.
//

import XCTest
import PromiseKit
@testable import DogsFact

class GetDogFactsUseCaseTest: XCTestCase {
    
    // Mock DogFactsRepository for testing
    class MockDogFactsRepository: DogFactsRepository {
        var apiResponse: DogFactData?
        var error: Error?
        func getRandomFact() -> Promise<DogFactData> {
            if let error = error {
                return Promise(error: error)
            }
            if let factsApiResponse = apiResponse {
                return Promise.value(factsApiResponse)
            }
            return Promise(error: URLSessionHTTPClientError.noData) // Default to no data
        }
    }
    
    var repository: MockDogFactsRepository!

    override func setUp() {
        super.setUp()
        repository = MockDogFactsRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    // Test fetching facts successfully
    func testGetDogFactsSuccess() {
        // Given
        guard let mockApiResponse = MockResponseManager.loadMockResponse(ofType: DogFactDTO.self, from: "DogFact") else {
            return
        }
        repository.apiResponse = mockApiResponse.toData
        
        let useCase = GetDogFactsUseCase(factsRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch facts successfully")
        let promise: Promise<DogFactData> = useCase.execute()
        
        promise.done { response in
            // Then
            XCTAssertEqual(response.factMessage, "Puppies then take a year or more to gain the other half of their body weight.")
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test fetching facts with an error
    func testGetDogFactsError() {
        // Given
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        repository.error = mockError
        
        let useCase = GetDogFactsUseCase(factsRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch facts with error")
        let promise: Promise<DogFactData> = useCase.execute()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertEqual(error as NSError, mockError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test fetching dog facts with no data
    func testGetDogFactsNoData() {
        // Given

        let useCase = GetDogFactsUseCase(factsRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch dog facts with no data")
        let promise: Promise<DogFactData> = useCase.execute()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertTrue(error is URLSessionHTTPClientError)
            XCTAssertEqual(error as? URLSessionHTTPClientError, URLSessionHTTPClientError.noData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

