//
//  BaseViewController.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 04/01/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    private var loadingSpinner: UIActivityIndicatorView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Navigation Bar
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
    
    // MARK: - Loading Spinner
    
    func showLoading() {
        if loadingSpinner == nil {
            loadingSpinner = UIActivityIndicatorView(style: .medium)
            loadingSpinner.center = view.center
            view.addSubview(loadingSpinner)
        }
        loadingSpinner.startAnimating()
    }
    
    func hideLoading() {
        loadingSpinner?.stopAnimating()
    }
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if actions.isEmpty {
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
        } else {
            for action in actions {
                alertController.addAction(action)
            }
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
