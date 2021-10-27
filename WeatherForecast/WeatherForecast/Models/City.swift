//
//  City.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

struct City: Identifiable, Codable {
    let id = UUID()
    let name: String
    let coord: Coord
    
    private enum CodingKeys: String, CodingKey {
        case name, coord
    }
}

struct Coord: Codable {
    let lat: Float
    let lon: Float
}

struct CityList: Codable {
    let list: [City]
}
