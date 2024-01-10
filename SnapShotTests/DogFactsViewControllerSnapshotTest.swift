//
//  DogFactsViewControllerSnapshotTest.swift
//  DogsFactTests
//
//  Created by Jyoti Kumari on 04/01/24.
//

import XCTest
import FBSnapshotTestCase
@testable import DogsFact

final class DogFactsViewControllerSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        // Set the recordMode to true initially to generate reference snapshots
        // self.recordMode = true
        bundleResourcePath = FileManager.default.temporaryDirectory.appendingPathComponent("ReferenceImages").path
        recordMode = false
        fileNameOptions = [
            FBSnapshotTestCaseFileNameIncludeOption.none
        ]
    }
    
    func testDogFactsViewController() {
        let dogFactsVC: DogFactsViewController = ViewControllerFactory.createDogFactsViewController()
        FBSnapshotVerifyView(dogFactsVC.view)
    }
}
