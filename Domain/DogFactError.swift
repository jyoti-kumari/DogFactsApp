//
//  DogFactError.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//
import Foundation

enum DogFactError: Error {
    case fetchError(Error)
    case notParsable(Data)
}
