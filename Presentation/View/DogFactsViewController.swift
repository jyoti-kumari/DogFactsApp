//
//  DogFactsViewController.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//
import Foundation
import UIKit

class DogFactsViewController: BaseViewController {
    var viewModelProtocol: DogFactsViewModelProtocol!
    
    // MARK: - Properties
    
    @IBOutlet weak var fetchAnotherFactBtn: UIButton!
    @IBOutlet weak var factTextView: UITextView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModelProtocol.getTitle()
        fetchRandomFact()
    }
    
    // MARK: - Private methods
    
    private func fetchRandomFact() {
        showLoading()
        viewModelProtocol.factMessage.bind { [weak self] _ in
            self?.hideLoading()
            self?.factTextView.text = self?.viewModelProtocol.factMessage.value
        }
        viewModelProtocol.errorMessage.bind { [weak self] error in
            self?.hideLoading()
            let errorMessage = self?.viewModelProtocol.errorMessage.value as? String
            self?.showAlert(title: NAConstants.factsLoadFail, message: errorMessage ?? NAConstants.defaultErrorMessage)
        }
        viewModelProtocol.fetchRandomFact()
    }
    
    // MARK: - Actions
    
    @IBAction func fetchAnotherFactClicked(_ sender: Any) {
        viewModelProtocol.onUserInput()
    }
}

