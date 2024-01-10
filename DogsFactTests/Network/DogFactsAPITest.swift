//
//  DogFactsAPITest.swift
//  DogsFactTests
//
//  Created by Jyoti Kumari on 10/01/24.
//

import XCTest
@testable import DogsFact

class DogFactsAPITest: XCTestCase {
    
    func testGetPathSuccess() {
        let correctURL = URL(string: "https://meowfacts.herokuapp.com/facts")
        let dogFactAPI = DogFactsAPI(environment: DogFactsEnvironment())
        let url = dogFactAPI.moreFactsURL
        XCTAssertEqual(url, correctURL)
    }
    
    func testGetPathFailure() {
        let correctURL = URL(string: "https://meowfacts.herokuapp.com/")
        let dogFactAPI = DogFactsAPI(environment: DogFactsEnvironment())
        let url = dogFactAPI.moreFactsURL
        XCTAssertFalse(correctURL == url)
    }
}
