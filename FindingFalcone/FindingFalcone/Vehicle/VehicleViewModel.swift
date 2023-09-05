//
//  VehicleViewModel.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 05/09/23.
//

import Foundation
protocol VehicleDataDelegate: AnyObject {
    func getVehicles(vehicles: [Vehicle])
    func getToken(tokenData: TokenResponse)
}

class VehicleViewModel {
    static let title = "Select Vehicles"
    static let resultTitle = "Show result"
    weak var delegate: VehicleDataDelegate?
    
    init() {
        getVehiclesData()
        getToken()
    }
    
}

// MARK: - Private methods
extension VehicleViewModel {
    private func getVehiclesData() {
        APIService.shared.getVehicles {[weak self] result in
            switch result {
            case .success(let vehicles):
                self?.delegate?.getVehicles(vehicles: vehicles)
            case.failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func getToken() {
        APIService.shared.getToken {[weak self] result in
            switch result {
            case .success(let tokenResponse):
                self?.delegate?.getToken(tokenData: tokenResponse)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
