//
//  VehicleHeaderView.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 05/09/23.
//

import UIKit

class VehicleHeaderView: UITableViewHeaderFooterView {
    static let identifier = "VehicleHeaderView"
       struct Constant {
           static let leadingConstraint = 10.0
           static let topConstraint = 10.0
       }
       
       
       private let planetNameLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize:17)
           label.textAlignment = .left
           label.textColor = .systemBlue
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
        private let distanceLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.textColor = .systemBlue
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
       
       override init(reuseIdentifier: String?) {
           super.init(reuseIdentifier: reuseIdentifier)
           setupUI()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           
       }
       
       // MAKR: - UI view constraints
       private func setupUIConstraints() {
           // label constraints
           NSLayoutConstraint.activate([
            planetNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.leadingConstraint),
            planetNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.leadingConstraint),
            planetNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.topConstraint)
           ])
           
           // Distance label constraints
           NSLayoutConstraint.activate([
            distanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.leadingConstraint),
            distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.leadingConstraint),
            distanceLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor, constant: Constant.topConstraint)
           ])
       }
   }

   // MARK: - Private methods
   extension VehicleHeaderView {
       private func setupUI() {
           contentView.addSubview(planetNameLabel)
           contentView.addSubview(distanceLabel)
           setupUIConstraints()
       }
   }

   // MARK: - Public methods
   extension VehicleHeaderView {
       public func configure(planet: Planet) {
           planetNameLabel.text = "Planet name: \(planet.name)"
           distanceLabel.text = "Distance: \(planet.distance)"
       }
}
