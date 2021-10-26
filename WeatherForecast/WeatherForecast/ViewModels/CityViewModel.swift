//
//  CityViewModel.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation

class CityViewModel : ObservableObject {
    @Published var cities: [City] = { () -> [City] in
        if let objects = UserDefaults.standard.value(forKey: "cities") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [City] {
                return objectsDecoded
            }
        }
        return []
    }()
    
    func addCity(_ name: String) -> Void {
        cities.append(City(id: UUID(), name: name))
        saveAllCities()
    }
    
    func deleteCity(_ index: IndexSet) -> Void {
        cities.remove(atOffsets: index)
        saveAllCities()
    }
    
    func saveAllCities() {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(cities){
             UserDefaults.standard.set(encoded, forKey: "cities")
          }
     }
}
