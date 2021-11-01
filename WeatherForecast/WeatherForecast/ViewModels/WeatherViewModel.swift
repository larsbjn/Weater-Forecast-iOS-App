//
//  WeatherViewModel.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var days: [Day] = []
    var city: City
    var selectedDayIndex: Int = 0
    
    init(city: City) {
        self.city = city
        
        CallWeatherForecastAPI(coord: city.coord) { [self] weatherWeek in
            for dayWeather in weatherWeek.daily {
                // Add timezone offset to match the timezone with the one from the location. So UTC time + timezone offset
                let date = Date(timeIntervalSince1970: Double(dayWeather.dt + Int(weatherWeek.timezone_offset)))
                self.days.append(Day(date: date, dayWeather: dayWeather, hourlyWeather: []))
            }
            
            guard self.days.count > 0 else { return }
            self.days[selectedDayIndex].toggleSelected()
            
            for day in 0...days.count - 1 {
                let startOfTheDay = days[day].date.timeIntervalSince1970 - days[day].date.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)
                let endOfTheDay = startOfTheDay + 86400
                
                for hour in weatherWeek.hourly {
                    if (Int(startOfTheDay) <= hour.dt && hour.dt < Int(endOfTheDay)) {
                        days[day].hourlyWeather.append(hour)
                    }
                }
            }
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
}
