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
    var hourlyWeather: [HourWeather]
    var isSelected = false
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date)
    }
    
    func getCurrentHourWeather() -> HourWeather? {
        let currentHour = Date().timeIntervalSince1970
        print(hourlyWeather)
        for hour in hourlyWeather {
            // Since the array is sorted by the earliest date, we can assume that when the hour minus the current hour is larger than 0, we hit the current hour
            if (hour.dt - Int(currentHour) > 0) {
                return hour
            }
        }
        return nil
    }
    
    mutating func toggleSelected() {
        isSelected.toggle()
    }
    
}
