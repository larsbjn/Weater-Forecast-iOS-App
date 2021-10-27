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
                let date = Date(timeIntervalSince1970: Double(dayWeather.dt))
                self.days.append(Day(date: date, weather: dayWeather))
            }
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
        guard selectedDayIndex >= 0 else { return nil}
        return days[selectedDayIndex]
    }
}
