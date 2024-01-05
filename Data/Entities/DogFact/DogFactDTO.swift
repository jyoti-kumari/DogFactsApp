//
//  DogFactDTO.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

struct DogFactDTO: Decodable {
    let facts: [String]
    let success: Bool
}
