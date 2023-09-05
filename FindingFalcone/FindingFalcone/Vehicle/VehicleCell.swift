//
//  TableViewCell.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 05/09/23.
//

import UIKit

struct VehicleCellConstants {
    static let vehicleName = "Unknow name"
    static let spaceConstraint = 10.0
}

class VehicleCell: UITableViewCell {
    static let identifier = "VehicleCell"
    
    private let vehicleNameLabel: UILabel = {
       let label = UILabel()
        label.text = VehicleCellConstants.vehicleName
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalNumberLabel: UILabel = {
       let label = UILabel()
        label.text = VehicleCellConstants.vehicleName
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxDistanceLabel: UILabel = {
       let label = UILabel()
        label.text = VehicleCellConstants.vehicleName
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speedLabel: UILabel = {
       let label = UILabel()
        label.text = VehicleCellConstants.vehicleName
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var isCellSelected: Bool {
        didSet {
            updateCell()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        isCellSelected = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        isCellSelected = false
        super.init(coder: coder)
    }
    
//    override func prepareForReuse() {
//        backgroundColor = .white
//        let subviews = [vehicleNameLabel, totalNumberLabel, maxDistanceLabel, speedLabel]
//        subviews.forEach({
//            $0.textColor = .black
//        })
//    }
    
    // MARK: - UI constraints
    private func setupConstraints() {
        // Vehicle name constraints
        NSLayoutConstraint.activate([
            vehicleNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: VehicleCellConstants.spaceConstraint),
            vehicleNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -VehicleCellConstants.spaceConstraint),
            vehicleNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: VehicleCellConstants.spaceConstraint)
        ])
        
        // Total number constraints
        NSLayoutConstraint.activate([
            totalNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: VehicleCellConstants.spaceConstraint),
            totalNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -VehicleCellConstants.spaceConstraint),
            totalNumberLabel.topAnchor.constraint(equalTo: vehicleNameLabel.bottomAnchor, constant: VehicleCellConstants.spaceConstraint)
        ])
        
        // Max distance constraints
        NSLayoutConstraint.activate([
            maxDistanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: VehicleCellConstants.spaceConstraint),
            maxDistanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -VehicleCellConstants.spaceConstraint),
            maxDistanceLabel.topAnchor.constraint(equalTo: totalNumberLabel.bottomAnchor, constant: VehicleCellConstants.spaceConstraint)
        ])
        
        // Speed label constraints
        NSLayoutConstraint.activate([
            speedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: VehicleCellConstants.spaceConstraint),
            speedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -VehicleCellConstants.spaceConstraint),
            speedLabel.topAnchor.constraint(equalTo: maxDistanceLabel.bottomAnchor, constant: VehicleCellConstants.spaceConstraint)
        ])
    }
}

// MARK: - Private methods
extension VehicleCell {
    private func setupUI() {
        let subviews = [vehicleNameLabel, totalNumberLabel, maxDistanceLabel, speedLabel]
       
        subviews.forEach({
            contentView.addSubview($0)
        })
        
        selectionStyle = .none
        setupConstraints()
    }
    
    private func updateCell() {
        let subviews = [vehicleNameLabel, totalNumberLabel, maxDistanceLabel, speedLabel]
        if isCellSelected {
            backgroundColor = .systemGreen
            subviews.forEach({
                $0.textColor = .white
            })
        } else {
            backgroundColor = .white
            subviews.forEach({
                $0.textColor = .black
            })
        }
    }
}

// MARK: - Public methods
extension VehicleCell {
    public func configure(vehicle: Vehicle) {
        vehicleNameLabel.text = "Vehicle name: \(vehicle.name)"
        totalNumberLabel.text = "Number of vehicle: \(vehicle.totalNumber)"
        maxDistanceLabel.text = "Maximum Distance: \(vehicle.maxDistance)"
        speedLabel.text = "Speed: \(vehicle.name)"
    }
    
    public func isSelectedCell(_ isSelected: Bool) {
        isCellSelected = isSelected
    }
}
