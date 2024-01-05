//
//  MockResponseManager.swift
//  DogsFactTests
//
//  Created by Jyoti Kumari on 04/01/24.
//

import Foundation

class MockResponseManager {
    
    static func loadMockResponse<T: Decodable>(ofType type: T.Type, from fileName: String) -> T? {
        let bundle = Bundle.main
        guard let filePath = bundle.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            let model = try JSONDecoder().decode(type, from: data)
            return model
        } catch {
            return nil
        }
    }
}
