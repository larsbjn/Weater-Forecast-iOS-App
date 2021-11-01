//
//  Weather.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 27/10/2021.
//

import Foundation
import SwiftUI

struct WeatherWeek: Codable {
    let daily: [DayWeather]
}

struct DayWeather: Codable {
    let dt: Int
    let temp: Temp
    let wind_speed: Float
    let weather: [Weather]
}

struct Temp: Codable {
    let day: Float
    let min: Float
    let max: Float
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
    
    // Read icon data from OpenWeatherAPI and translate to a SF Figure Icon from Apple
    func getIcon() -> Icon {
        switch icon {
        case "01d":
            return Icon(name: "sun.max", primaryColor: .yellow, secondaryColor: .yellow)
        case "02d":
            return Icon(name: "cloud.sun", primaryColor: .blue, secondaryColor: .yellow)
        case "03d":
            return Icon(name: "cloud", primaryColor: .blue, secondaryColor: .blue)
        case "04d":
            return Icon(name: "cloud.fill", primaryColor: .gray, secondaryColor: .gray)
        case "09d":
            return Icon(name: "cloud.drizzle", primaryColor: .gray, secondaryColor: .blue)
        case "10d":
            return Icon(name: "cloud.rain", primaryColor: .gray, secondaryColor: .blue)
        case "11d":
            return Icon(name: "cloud.bolt", primaryColor: .gray, secondaryColor: .yellow)
        case "13d":
            return Icon(name: "cloud.snow", primaryColor: .gray, secondaryColor: .gray)
        case "50d":
            return Icon(name: "cloud.fog", primaryColor: .gray, secondaryColor: .gray)
        default:
            return Icon(name: "questionmark", primaryColor: .gray, secondaryColor: .gray)
        }
    
    }
    
    struct Icon {
        let name: String
        let primaryColor: Color
        let secondaryColor: Color
    }
}
