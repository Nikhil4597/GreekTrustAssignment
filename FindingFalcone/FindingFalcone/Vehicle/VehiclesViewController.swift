//
//  VehiclesViewController.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 05/09/23.
//

import UIKit

enum Sections: Int {
    case firstPlanet = 0
    case secondPlanet
    case thirdPlanet
    case fourthPlanet
}

struct VehiclesViewControllerConstants {
    static let largeTopConstraint = 100.0
    static let leadingConstraint = 10.0
    static let spaceConstraints = 10.0
    static let cellHeight = 150.0
    static let headerViewHeight = 100.0
}

class VehiclesViewController: UIViewController {
    private var viewModel: VehicleViewModel? = nil
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(VehicleCell.self, forCellReuseIdentifier: VehicleCell.identifier)
        view.register(VehicleHeaderView.self, forHeaderFooterViewReuseIdentifier: VehicleHeaderView.identifier)
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    private let resultButton: UIButton = {
      let button = UIButton()
        button.setTitle(VehicleViewModel.resultTitle, for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.isHidden = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var selectedPlanets: [Planet] = [] {
        didSet {
            updateTableView()
        }
    }
    
    private var vehicleEntities: [VehicleEntity] = [] {
        didSet {
            updateTableView()
        }
    }
    
    private var token: String = ""
    
    private var dictionary: [Planet: Vehicle] = [:] {
        didSet {
            if dictionary.count == 4 {
                resultButton.isHidden = false
            } else {
                resultButton.isHidden = true
            }
        }
    }
    
    private var selectedCell: [Int: Int] = [:] {
        didSet {
//            updateTableView()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    // MARK: UI constraints
    private func setupUIConstraints() {
        // Result button constraints
        NSLayoutConstraint.activate([
            resultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -VehiclesViewControllerConstants.spaceConstraints),
            resultButton.widthAnchor.constraint(equalToConstant: 100),
            resultButton.heightAnchor.constraint(equalToConstant: 50),
            resultButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -3*VehiclesViewControllerConstants.spaceConstraints)
        ])
        
        // Table view constraints
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: VehiclesViewControllerConstants.spaceConstraints),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -VehiclesViewControllerConstants.spaceConstraints),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: VehiclesViewControllerConstants.largeTopConstraint),
            tableView.bottomAnchor.constraint(equalTo: resultButton.topAnchor, constant: -VehiclesViewControllerConstants.spaceConstraints)
        ])
    }
}

// MARK: - Private methods
extension VehiclesViewController {
    private func setupUI() {
        view.backgroundColor = .white
        title = VehicleViewModel.title
        view.addSubview(resultButton)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        setupUIConstraints()
    }
    
    @objc private func resultButtonTapped() {
        let planets = dictionary.keys
        let planetsName = planets.map({
            $0.name
        })
        
        let vehiclesName = planets.map({
            if let name = dictionary[$0]?.name {
                return name
            }
            return ""
        })
        
        let findRequestData = FindRequestData(token: token, planetNames: planetsName, vehicleNames: vehiclesName)
        
        let resultViewController = ResultViewController()
        resultViewController.configure(resultData: findRequestData)
        navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    private func setupViewModel() {
        viewModel = VehicleViewModel()
        viewModel?.delegate = self
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Public methods
extension VehiclesViewController {
    public func configure(selectedPlanets: [Planet]) {
        self.selectedPlanets = selectedPlanets
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension VehiclesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        selectedPlanets.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vehicleEntities.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let planet = selectedPlanets[section]
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: VehicleHeaderView.identifier) as! VehicleHeaderView
        header.configure(planet: planet)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as? VehicleCell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case Sections.firstPlanet.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as? VehicleCell {
                let vehicle = vehicleEntities[indexPath.row].vehicle
                cell.configure(vehicle: vehicle)
                return cell
            }
            
        case Sections.secondPlanet.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as? VehicleCell {
                let vehicle = vehicleEntities[indexPath.row].vehicle
                cell.configure(vehicle: vehicle)
                return cell
            }
            
        case Sections.thirdPlanet.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as? VehicleCell {
                let vehicle = vehicleEntities[indexPath.row].vehicle
                cell.configure(vehicle: vehicle)
                return cell
            }
            
        case Sections.fourthPlanet.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as? VehicleCell {
                let vehicle = vehicleEntities[indexPath.row].vehicle
                cell.configure(vehicle: vehicle)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let rowIndex = selectedCell[indexPath.section] {
            let previousIndexPath = IndexPath(row: rowIndex, section: indexPath.section)
            if let  previouslySelectedCell = tableView.cellForRow(at: previousIndexPath) as? VehicleCell {
                previouslySelectedCell.isSelectedCell(false)
            }
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? VehicleCell {
            let vehicleEntity = vehicleEntities[indexPath.row]
            vehicleEntity.isSelected = !vehicleEntity.isSelected
            cell.isSelectedCell(vehicleEntity.isSelected)
            
            if vehicleEntity.isSelected {
                dictionary[selectedPlanets[indexPath.section]] = vehicleEntity.vehicle
            }
            
            selectedCell[indexPath.section] = indexPath.row
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        VehiclesViewControllerConstants.headerViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        VehiclesViewControllerConstants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let rowIndex = selectedCell[indexPath.section],
        rowIndex == indexPath.row {
            DispatchQueue.main.async {
                if let cell = tableView.cellForRow(at: indexPath) as? VehicleCell {
                    cell.isSelectedCell(true)
                }
            }
        }
    }
}

// MARK: - VehicleDataDelegate
extension VehiclesViewController: VehicleDataDelegate {
    func getVehicles(vehicles: [Vehicle]) {
        vehicles.forEach({
            vehicleEntities.append(VehicleEntity(vehicle: $0, isSelected: false))
        })
    }
    
    func getToken(tokenData: TokenResponse) {
        self.token = tokenData.token
    }
}
