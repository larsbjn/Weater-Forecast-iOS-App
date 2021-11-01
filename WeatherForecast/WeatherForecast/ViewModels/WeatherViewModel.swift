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
    var selectedDayIndex: Int = 0
    
    init(city: City) {
        self.city = city
        
        CallWeatherForecastAPI(coord: city.coord) { [self] weatherWeek in
            for dayWeather in weatherWeek.daily {
                // Add timezone offset to match the timezone with the one from the location. So UTC time + timezone offset
                let date = Date(timeIntervalSince1970: Double(dayWeather.dt + Int(weatherWeek.timezone_offset)))
                self.days.append(Day(date: date, dayWeather: dayWeather))
            }
            hourly = weatherWeek.hourly
            
            guard self.days.count > 0 else { return }
            self.days[selectedDayIndex].toggleSelected()
        }
    }
    
    func selectDay(weather: Day) {
        days[selectedDayIndex].toggleSelected()
        selectedDayIndex = days.firstIndex(where: { $0.id == weather.id } ) ?? -1
        days[selectedDayIndex].toggleSelected()
    }
    
    func getSelectedDay() -> Day? {
        guard selectedDayIndex >= 0, !days.isEmpty else { return nil}
        return days[selectedDayIndex]
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
