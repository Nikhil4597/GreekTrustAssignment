//
//  PlanetCell.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 04/09/23.
//

import UIKit

struct PlanetCellConstants {
    static let planetDefaultName = "Unknown Planet"
    static let defaultDistance = 0
    static let leadingConstraint = 10.0
    static let topConstraints = 10.0
}

class PlanetCell: UITableViewCell {
    static let identifier = "PlanetCell"
    private let planetNameLabel: UILabel = {
        let label = UILabel()
        label.text = PlanetCellConstants.planetDefaultName
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = String(PlanetCellConstants.defaultDistance)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        isCellClicked = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private var isCellClicked: Bool {
        didSet {
            if isCellClicked {
                backgroundColor = .systemGreen
                planetNameLabel.textColor = .white
                distanceLabel.textColor = .white
            } else {
                backgroundColor = .white
                planetNameLabel.textColor = .black
                distanceLabel.textColor = .black
            }
        }
    }
    
    required init?(coder: NSCoder) {
        isCellClicked = false
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        isCellClicked = false
    }
    
    // MARK: - UI Constraints
    private func setupConstraints() {
        // Planet name label constraints
        NSLayoutConstraint.activate([
            planetNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PlanetCellConstants.leadingConstraint),
            planetNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PlanetCellConstants.leadingConstraint),
            planetNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PlanetCellConstants.topConstraints)
        ])
        
        // Distance label constraints
        NSLayoutConstraint.activate([
            distanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PlanetCellConstants.leadingConstraint),
            distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PlanetCellConstants.leadingConstraint),
            distanceLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor, constant: PlanetCellConstants.topConstraints)
        ])
    }
}


// MARK: - Private methods
extension PlanetCell {
    private func setupUI() {
        contentView.addSubview(planetNameLabel)
        contentView.addSubview(distanceLabel)
        selectionStyle = .none
        setupConstraints()
    }
}

// MARK: - Pulbic methods
extension PlanetCell {
    public func configure(planet: Planet) {
        planetNameLabel.text = "Planet Name: \(planet.name)"
        distanceLabel.text = "Distance: \(planet.distance)"
    }
    
    public func toggleSelection(isSelected: Bool) {
        isCellClicked = isSelected
    }
}
