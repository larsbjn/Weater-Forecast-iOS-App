//
//  Weather.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 27/10/2021.
//

import Foundation

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
}
