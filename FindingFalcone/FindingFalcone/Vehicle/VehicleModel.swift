//
//  VehicleModel.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 05/09/23.
//

import Foundation

class VehicleEntity: Equatable {
    let vehicle: Vehicle
    var isSelected: Bool
    
    init(vehicle: Vehicle, isSelected: Bool) {
        self.vehicle = vehicle
        self.isSelected = isSelected
    }
    
    static func == (lhs: VehicleEntity, rhs: VehicleEntity) -> Bool {
        return lhs.vehicle == rhs.vehicle && lhs.isSelected == rhs.isSelected
    }
}
