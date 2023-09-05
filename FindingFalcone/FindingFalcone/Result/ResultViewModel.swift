//
//  File.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 05/09/23.
//

import Foundation

protocol FindResultProtocol: AnyObject {
    func sharedResult(result: String)
}

class ResultViewModel {
    weak var delegate: FindResultProtocol?
    init(findRequestData: FindRequestData) {
        getData(findRequestData)
    }
}

// MARK: - private method
extension ResultViewModel {
    private func getData(_ data: FindRequestData) {
        APIService.shared.getResult(selectedItems: data) {[weak self] result in
            switch result {
            case .success(let successData):
                self?.delegate?.sharedResult(result: "\(successData.planetName) \(successData.status)")
            case .failed(let failedData):
                self?.delegate?.sharedResult(result: failedData.status)
            case .error(let errorData):
                self?.delegate?.sharedResult(result: errorData.error)
            }
        }
    }
}
