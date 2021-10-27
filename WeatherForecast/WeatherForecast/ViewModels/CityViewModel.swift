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
        URLSession.shared.dataTask(with: findCityURL(name: name), completionHandler: { [self] data, response, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            
            var result: CityList?
            do {
                result = try JSONDecoder().decode(CityList.self, from: data)
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
            }

            guard let parsed = result, let city = parsed.list.first else {
                print("Error parsing data to JSON or no cities found")
                return
            }
            DispatchQueue.main.async {
                cities.append(city)
                saveAllCities()
            }
        }).resume()
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
    
    private func findCityURL(name: String) -> URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/find?q=\(name)&units=metric&appid=adba724c1b24f0ac1891014c813065c8")!
    }
}
