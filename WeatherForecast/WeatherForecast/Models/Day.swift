//
//  Weather.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

struct Day: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let dayWeather: DayWeather
    var isSelected = false
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date)
    }
    
    mutating func toggleSelected() {
        isSelected.toggle()
    }
    
}
