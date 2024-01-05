//
//  DogFactsViewController.swift
//  DogsFact
//
//  Created by Jyoti Kumari on 02/01/24.
//
import Foundation
import UIKit

class DogFactsViewController: BaseViewController {
    private var viewModel: DogFactsViewModel!
    
    // MARK: - Properties
    
    @IBOutlet weak var fetchAnotherFactBtn: UIButton!
    @IBOutlet weak var factTextView: UITextView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NAConstants.title
        commonInit()
        showLoading()
        viewModel.fetchRandomFact()
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        self.viewModel = makeViewModel(dogFactsUseCase: makeRepository(), onSuccess: { [weak self] in self?.onSuccess(factMessage: $0) }, onError: { [weak self] in self?.onError(errorMessage: $0) })
    }

    fileprivate func makeRepository() -> GetDogFactsUseCaseProtocol {
        GetDogFactsUseCase(factsRepository: DogFactsRemoteRepository(httpClient: URLSessionHTTPClient(), api: .dev))
    }
    
    fileprivate func makeViewModel(dogFactsUseCase: GetDogFactsUseCaseProtocol,
                                   onSuccess: @escaping (_ factValue: String) -> Void,
                                   onError: @escaping (_ errormMessage: String) -> Void
    ) -> DogFactsViewModel {
        DogFactsViewModel(dogFactsUseCase: dogFactsUseCase, onSuccess: onSuccess, onError: onError)
    }
    
    // MARK: - Actions
    
    @IBAction func fetchAnotherFactClicked(_ sender: Any) {
        viewModel.onUserInput(.fetchFactClicked)
    }
    
    // MARK: - UI update on api response
    
    func onSuccess(factMessage: String) {
        hideLoading()
        self.factTextView.text = factMessage
    }
    
    func onError(errorMessage: String) {
        hideLoading()
        showAlert(title: NAConstants.factsLoadFail, message: errorMessage)
    }
}

