//
//  DogFactsRemoteRepositoryTest.swift
//  DogsFactTests
//
//  Created by Jyoti Kumari on 09/01/24.
//

import XCTest
import PromiseKit
@testable import DogsFact

class DogFactsRemoteRepositoryTest: XCTestCase {
    var session: MockURLSession!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
    }
    
    override func tearDown() {
        session = nil
        super.tearDown()
    }
    
    // Test successful API request
    func testAPIRequestSuccess() {
        // Given
        
        session.data = """
            {
                "facts": [
                    "Puppies then take a year or more to gain the other half of their body weight."
                ],
                "success": true
            }
            """.data(using: .utf8)
        
        let sessionManager = APIManager(session: session)
        let dogFactsRemoteRepo = DogFactsRemoteRepository(apiService: sessionManager, api: .test)
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<DogFactData> = dogFactsRemoteRepo.getRandomFact()
        promise.done { response in
            // Then
            XCTAssertNotNil(response)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test API request failure
    func testAPIRequestFailure() {
        // Given
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        
        session.error = mockError
        
        let sessionManager = APIManager(session: session)
        let dogFactsRemoteRepo = DogFactsRemoteRepository(apiService: sessionManager, api: .test)
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<DogFactData> = dogFactsRemoteRepo.getRandomFact()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertEqual(error as NSError, mockError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test API request with no data
    func testAPIRequestNoData() {
        
        session.data = nil
        
        let sessionManager = APIManager(session: session)
        let dogFactsRemoteRepo = DogFactsRemoteRepository(apiService: sessionManager, api: .test)
        
        // When
        let expectation = XCTestExpectation(description: "API request with no data")
        let promise: Promise<DogFactData> = dogFactsRemoteRepo.getRandomFact()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, APIError.noData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    // Test API request with decoding error
    func testAPIRequestDecodingError() {
        // Given
        let mockData = """
            {
                "invalidKey": "Test Article"
            }
            """.data(using: .utf8)
        
        session.data = mockData
        
        let sessionManager = APIManager(session: session)
        let dogFactsRemoteRepo = DogFactsRemoteRepository(apiService: sessionManager, api: .test)
        
        // When
        let expectation = XCTestExpectation(description: "API request with decoding error")
        let promise: Promise<DogFactData> = dogFactsRemoteRepo.getRandomFact()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, APIError.decodingError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// Mock implementations for testing
extension DogFactsRemoteRepositoryTest {
    struct MockEnvironment {
        var api: DogFactsAPI = DogFactsAPI(environment: "" as! Environment)
    }
}

extension DogFactsAPI {
    static var test: Self {
        DogFactsAPI(environment: DogFactsEnvironment())
    }
}
