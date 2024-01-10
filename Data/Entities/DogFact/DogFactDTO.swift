//
//  DogFactDTO.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//

struct DogFactDTO: Decodable {
    let data: [String]
}

extension DogFactDTO {
    var toData: DogFactData {
        return DogFactData(
            factMessage: data.reduce(into: "", { $0.append(contentsOf: $1) }))
    }
}
