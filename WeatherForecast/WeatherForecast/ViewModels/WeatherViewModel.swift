//
//  WeatherViewModel.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weathers: [Weather] = []
    var selectedDayIndex: Int = 0
    
    init() {
        var dateComponent = DateComponents()
        dateComponent.month = 10
        
        for i in 1...10 {
            dateComponent.day = i
            let weather = Weather(id: UUID(), date: dateComponent);
            weathers.append(weather)
        }
        weathers[selectedDayIndex].toggleSelected()
    }
    
    func selectDay(weather: Weather) {
        weathers[selectedDayIndex].toggleSelected()
        selectedDayIndex = weathers.firstIndex(where: { $0.id == weather.id } ) ?? -1
        weathers[selectedDayIndex].toggleSelected()
    }
    
    func getSelectedDay() -> Weather? {
        guard selectedDayIndex >= 0 else { return nil}
        return weathers[selectedDayIndex]
    }
}
