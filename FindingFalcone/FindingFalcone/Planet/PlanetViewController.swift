//
//  ViewController.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 04/09/23.
//

import UIKit

struct PlanetViewControllerConstants {
    static let numberOfSection = 1
    static let cellHeight = 100.0
    static let largeTopConstraint = 100.0
    static let space = 10.0
    static let cornerRadius = 5.0
}

class PlanetViewController: UIViewController {
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(PlanetCell.self, forCellReuseIdentifier: PlanetCell.identifier)
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nextButton: UIButton = {
       let button = UIButton()
        button.setTitle(PlanetViewModel.nextButtonTitle, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = PlanetViewControllerConstants.cornerRadius
        button.clipsToBounds = true
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var viewModel: PlanetViewModel? = nil
    private var planetsEntities: [PlanetEntity]? = [] {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private var selectedPlanets: [Planet]? = [] {
        didSet {
            DispatchQueue.main.async {[weak self] in
                if self?.selectedPlanets?.count == 4 {
                    self?.nextButton.isHidden = false
                } else {
                    self?.nextButton.isHidden = true
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    // MARK: - UI Constraints
    private func setupConstrainst() {
        // Guide label constrainst
        NSLayoutConstraint.activate([
            guideLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PlanetViewControllerConstants.space),
            guideLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PlanetViewControllerConstants.space),
            guideLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: PlanetViewControllerConstants.largeTopConstraint)
        ])
        
        // Next button constraints
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PlanetViewControllerConstants.space),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -3*PlanetViewControllerConstants.space)
        ])
        
        // Table view constraints
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PlanetViewControllerConstants.space),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PlanetViewControllerConstants.space),
            tableView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: PlanetViewControllerConstants.space),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -PlanetViewControllerConstants.space)
        ])
    }
}


// MARK: Private methods
extension PlanetViewController {
    private func setupUI() {
        view.backgroundColor = .white
        title = PlanetViewModel.title
        
        let subviews = [guideLabel, nextButton, tableView]
        subviews.forEach({
            view.addSubview($0)
        })

        tableView.dataSource = self
        tableView.delegate = self
        
        guideLabel.text = PlanetViewModel.guideTitle
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        setupConstrainst()
    }
    
    @objc private func nextButtonClicked() {
        let vehicleViewController = VehiclesViewController()
        if let selectedPlanets = selectedPlanets {
            vehicleViewController.configure(selectedPlanets: selectedPlanets)
        }
        
        navigationController?.pushViewController(vehicleViewController, animated: true)
    }
    
    private func setupViewModel() {
        viewModel = PlanetViewModel()
        viewModel?.delegate = self
    }
    
    private func add(planet: Planet) {
        selectedPlanets?.append(planet)
    }
    
    private func remove(removalPlanet: Planet) {
        if let planets = selectedPlanets,
           !planets.isEmpty {
            for (index, planet) in planets.enumerated() {
                if planet == removalPlanet {
                    selectedPlanets?.remove(at: index)
                }
            }
        }
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension PlanetViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        PlanetViewControllerConstants.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PlanetViewControllerConstants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planetsEntities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanetCell.identifier, for: indexPath) as? PlanetCell else {
            return UITableViewCell()
        }
        
        if let planetEntity = planetsEntities?[indexPath.row] {
            cell.configure(planet: planetEntity.planet)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PlanetCell else {
            return
        }
        
        if let planetEntity = planetsEntities?[indexPath.row] {
            planetEntity.isSelected = !planetEntity.isSelected
            cell.toggleSelection(isSelected: planetEntity.isSelected)
            if planetEntity.isSelected {
                add(planet: planetEntity.planet)
            } else {
                remove(removalPlanet: planetEntity.planet)
            }
        }
    }
}

// MARK: - PlanetsDataDelegate
extension PlanetViewController: PlanetsDataDelegate {
    func getPlanets(planetsEntities: [PlanetEntity]) {
        self.planetsEntities = planetsEntities
    }
}
