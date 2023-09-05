//
//  ResultViewController.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 05/09/23.
//

import UIKit

class ResultViewController: UIViewController {
    private var viewModel: ResultViewModel? = nil
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 24, weight:  .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultLabel.frame = view.bounds
    }
}

// MARK: - Private methods
extension ResultViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(resultLabel)
        
    }
}

// MARK: - Public methods
extension ResultViewController {
    public func configure(resultData: FindRequestData) {
        viewModel = ResultViewModel(findRequestData: resultData)
        viewModel?.delegate = self
    }
}

// MARK: -
extension ResultViewController: FindResultProtocol {
    func sharedResult(result: String) {
        DispatchQueue.main.async {[weak self] in
            self?.resultLabel.text = result
        }
    }
}
