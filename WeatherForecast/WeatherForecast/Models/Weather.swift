//
//  Weather.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 27/10/2021.
//

import Foundation
import SwiftUI

struct WeatherWeek: Codable {
    let timezone_offset: Float
    let hourly: [HourWeather]
    let daily: [DayWeather]
}

struct HourWeather: Codable, Identifiable {
    let id = UUID()
    let dt: Int
    let temp: Float
    let feels_like: Float
    let wind_speed: Float
    let weather: [Weather]
    
    func getHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        return dateFormatter.string(from: date)
    }
    
    private enum CodingKeys: String, CodingKey {
        case dt, temp, feels_like, wind_speed, weather
    }
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
        case _ where icon.contains("01"):
            return Icon(name: "sun.max", primaryColor: .yellow, secondaryColor: .yellow)
        case _ where icon.contains("02"):
            return Icon(name: "cloud.sun", primaryColor: .blue, secondaryColor: .yellow)
        case _ where icon.contains("03"):
            return Icon(name: "cloud", primaryColor: .blue, secondaryColor: .blue)
        case _ where icon.contains("04"):
            return Icon(name: "cloud.fill", primaryColor: .blue, secondaryColor: .blue)
        case _ where icon.contains("09"):
            return Icon(name: "cloud.drizzle", primaryColor: .gray, secondaryColor: .blue)
        case _ where icon.contains("10"):
            return Icon(name: "cloud.rain", primaryColor: .gray, secondaryColor: .blue)
        case _ where icon.contains("11"):
            return Icon(name: "cloud.bolt", primaryColor: .gray, secondaryColor: .yellow)
        case _ where icon.contains("13"):
            return Icon(name: "cloud.snow", primaryColor: .gray, secondaryColor: .gray)
        case _ where icon.contains("50"):
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
