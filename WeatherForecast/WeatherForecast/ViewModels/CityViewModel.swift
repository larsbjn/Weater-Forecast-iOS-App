//
//  CityViewModel.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import Foundation
import SwiftUI
import CoreData

class CityViewModel : ObservableObject {
    
    @Published var cities: [City] = []
    
    let context = PersistenceController.shared.container.viewContext
    var citiesEntities: [CityEntity] = []
    
    init() {
        let request = NSFetchRequest<CityEntity>(entityName: "CityEntity")
        
        guard let fetchedCities = try? context.fetch(request) else { return }
        self.citiesEntities = fetchedCities
        
        for city in citiesEntities {
            let newCoord = Coord(lat: city.coord?.lat ?? 0, lon: city.coord?.lon ?? 0)
            cities.append(City(name: city.name ?? "", coord: newCoord))
        }
        
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
            
            self.addCityEntity(city: city)
        })
        
    }
    
    func addCityEntity(city: City) {
        let newCoord = CoordEntity(context: context)
        newCoord.lon = city.coord.lon
        newCoord.lat = city.coord.lat
        
        let newCity = CityEntity(context: context)
        newCity.name = city.name
        newCity.coord = newCoord
        
        citiesEntities.append(newCity)
        
        try? context.save()
    }
    
    func deleteCity(_ index: IndexSet) -> Void {
        guard let i = index.first else { return }
        deleteCityEntity(city: cities[i])
        cities.remove(atOffsets: index)
    }
    
    func deleteCityEntity(city: City) {
        for c in citiesEntities {
            if c.name == city.name {
                context.delete(c)
                try? context.save()
                return
            }
        }
    }
}
