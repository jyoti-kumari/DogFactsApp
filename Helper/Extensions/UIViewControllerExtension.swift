//
//  UIViewControllerExtension.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 04/01/24.
//

import Foundation
import UIKit

extension UIViewController {
    enum StoryboardName: String {
        case main = "Main"
        // Add more storyboard names here as needed
    }
    /// Instantiates a view controller of the specified type from a storyboard.
    /// - Parameters:
    ///   - named: The name of the storyboard where the view controller is located. Default is `.main`.
    ///   - identifier: The optional identifier of the view controller in the storyboard. If not provided, the identifier is inferred from the view controller's type.
    /// - Returns: An instance of the specified view controller type.
    static func instantiateFromStoryboard<T: UIViewController>(named storyboardName: StoryboardName = .main, identifier: String? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let viewControllerIdentifier = identifier ?? String(describing: T.self)
        if let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? T {
            return viewController
        } else {
            fatalError("Failed to instantiate view controller from storyboard.")
        }
    }
}
