//
//  WeatherViewModel.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weathers: [Weather] = []
    var city: City
    var selectedDayIndex: Int = 0
    
    init(city: City) {
        self.city = city
        
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


/*
 {
    "city":{
       "id":2643743,
       "name":"London",
       "coord":{
          "lon":-0.1258,
          "lat":51.5085
       },
       "country":"GB",
       "population":0,
       "timezone":3600
    },
    "cod":"200",
    "message":0.7809187,
    "cnt":7,
    "list":[
       {
          "dt":1568977200,
          "sunrise":1568958164,
          "sunset":1569002733,
          "temp":{
             "day":293.79,
             "min":288.85,
             "max":294.47,
             "night":288.85,
             "eve":290.44,
             "morn":293.79
          },
          "feels_like":{
             "day":278.87,
             "night":282.73,
             "eve":281.92,
             "morn":278.87
          },
          "pressure":1025.04,
          "humidity":42,
          "weather":[
             {
                "id":800,
                "main":"Clear",
                "description":"sky is clear",
                "icon":"01d"
             }
          ],
          "speed":4.66,
          "deg":102,
          "gust":5.3,
          "clouds":0,
          "pop":0.24
       }
    ]
 }
*/
