//
//  Weather.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

struct Weather: Identifiable, Codable {
    let id: UUID
    let date: DateComponents
    var isSelected = false
    
    func getDay() -> String {
        return date.day != nil ? String(date.day!) : ""
    }
    
    func getMonth() -> String {
        return date.month != nil ? String(date.month!) : ""
    }
    
    mutating func toggleSelected() {
        isSelected.toggle()
    }
    
}
