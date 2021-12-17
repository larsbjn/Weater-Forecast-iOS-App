//
//  CityViewModel.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation
import SwiftUI

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
    
    init() {
        let locationManager = LocationManager()
        locationManager.setOnLocationGranted(action: {
            guard let location = locationManager.getLocation() else { return }
            
            CallCityNameByCoordinatesAPI(coord: Coord(lat: Float(location.coordinate.latitude), lon: Float(location.coordinate.longitude)), action: { cityByCoordinate in
                guard let city = cityByCoordinate.first else { return }
                var c = City(name: "\(city.name)", coord: Coord(lat: city.lat, lon: city.lon))
                c.isGps = true
                self.cities.insert(c, at: 0)
            })
        })
        locationManager.setOnLocationRemoved(action: {
            guard self.cities[0].isGps else { return }
            self.cities.remove(at: 0)
        })
    }
    
    func addCity(_ name: String) -> Void {
        CallFindCityAPI(name: name, action: { cityList in
            guard let city = cityList.list.first else { return }
            self.cities.append(city)
            self.saveAllCities()
        })
    }
    
    func deleteCity(_ index: IndexSet) -> Void {
        cities.remove(atOffsets: index)
        saveAllCities()
    }
    
    func saveAllCities() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cities.filter({ !$0.isGps })){
            UserDefaults.standard.set(encoded, forKey: "cities")
        }
    }
}
