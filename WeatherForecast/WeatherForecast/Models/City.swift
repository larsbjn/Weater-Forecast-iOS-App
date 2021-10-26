//
//  City.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

struct City: Identifiable, Codable {
    let id: UUID
    let name: String
}
