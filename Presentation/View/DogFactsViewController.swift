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
        self.title = viewModelProtocol.getTitle
        fetchRandomFact()
    }
    
    // MARK: - Private methods
    
    private func fetchRandomFact() {
        showLoading()
        viewModelProtocol.fetchRandomFact()
    }
    
    // MARK: - Actions
    
    @IBAction func fetchAnotherFactClicked(_ sender: Any) {
        viewModelProtocol.onUserInput()
    }
}

extension DogFactsViewController: DogFactsViewModelOutput {
    func handleSuccess() {
        hideLoading()
        factTextView.text = viewModelProtocol.factMessage
    }
    
    func handleFailure(_ message: String) {
        hideLoading()
        showAlert(title: StringConstant.factsLoadFail, message: message)
    }
}
