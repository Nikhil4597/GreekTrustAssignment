//
//  TableSectionModel.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 04/09/23.
//

import Foundation

class PlanetEntity {
    let planet: Planet
    var isSelected: Bool

    init(planet: Planet, isSelected: Bool) {
        self.planet = planet
        self.isSelected = isSelected
    }
}
