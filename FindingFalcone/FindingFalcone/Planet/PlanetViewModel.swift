//
//  ViewModel.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 04/09/23.
//

import Foundation

protocol PlanetsDataDelegate: AnyObject {
    func getPlanets(planetsEntities: [PlanetEntity])
}

class PlanetViewModel {
    static let title = "Planets"
    static let guideTitle = "Please select any 4 planets."
    static let nextButtonTitle = "Next"
    weak var delegate: PlanetsDataDelegate?
    init() {
       getPlanets()
    }
}

// MARK: - Private methods
extension PlanetViewModel {
    private func getPlanets() {
        APIService.shared.getPlanets {[weak self] result in
            switch result {
            case .success(let planets):
                var planetsEntities: [PlanetEntity] = []
                planets.forEach({
                    planetsEntities.append(PlanetEntity(planet: $0, isSelected: false))
                })

                self?.delegate?.getPlanets(planetsEntities: planetsEntities)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
