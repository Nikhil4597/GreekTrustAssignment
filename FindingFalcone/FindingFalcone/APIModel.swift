//
//  APIModel.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 04/09/23.
//

import Foundation

struct Planet: Codable, Equatable, Hashable {
    let name: String
    let distance: Int
}

struct Vehicle: Codable, Equatable {
    let name: String
    let totalNumber: Int
    let maxDistance: Int
    let speed: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case totalNumber = "total_no"
        case maxDistance = "max_distance"
        case speed
    }
}

struct TokenResponse: Codable {
    let token: String
}

struct FindRequestData: Codable {
    let token: String
    let planetNames: [String]
    let vehicleNames: [String]
    
    enum CodingKeys: String, CodingKey {
        case token
        case planetNames = "planet_names"
        case vehicleNames = "vehicle_names"
    }
}

struct FindSuccessResponse: Codable {
    let planetName: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case planetName = "planet_name"
        case status
    }
}

struct FindFailedResponse: Codable {
    let status: String
}

struct FindErrorResponse: Codable {
    let error: String
}
