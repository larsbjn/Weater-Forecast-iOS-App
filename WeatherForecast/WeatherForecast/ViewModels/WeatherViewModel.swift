//
//  WeatherViewModel.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var days: [Day] = []
    @Published var hourly: [HourWeather] = []
    var city: City
    
    init(city: City) {
        self.city = city
        
        CallWeatherForecastAPI(coord: city.coord) { [self] weatherWeek in
            for dayWeather in weatherWeek.daily {
                // Add timezone offset to match the timezone with the one from the location. So UTC time + timezone offset
                let date = Date(timeIntervalSince1970: Double(dayWeather.dt - (dayWeather.dt % 86400) - Int(weatherWeek.timezone_offset)))
                self.days.append(Day(date: date, dayWeather: dayWeather))
            }
            hourly = weatherWeek.hourly

        }
    }
    
    func getCityName() -> String {
        return city.name
    }
    
    func getCurrentDay() -> Day? {
        let currentHour = Date().timeIntervalSince1970
        for day in days {
        
            if (day.date.timeIntervalSince1970 - currentHour < 0) {
                return day
            }
        }
        return nil
    }
    
    func getCurrentHourWeather() -> HourWeather? {
        let currentHour = Date().timeIntervalSince1970
        for hour in hourly {
            // Since the array is sorted by the earliest date, we can assume that when the hour minus the current hour is smaller than 0, we hit the current hour
            if (hour.dt - Int(currentHour) < 0) {
                return hour
            }
        }
        return nil
    }
}
