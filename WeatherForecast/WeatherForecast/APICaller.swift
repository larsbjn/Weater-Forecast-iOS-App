//
//  APICaller.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 27/10/2021.
//

import Foundation

func FindCity(name: String, action: @escaping (_ city: City) -> Void) {
    URLSession.shared.dataTask(with: findCityURL(name: name), completionHandler: { data, response, error in
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
            action(city)
        }
    }).resume()
}

private func findCityURL(name: String) -> URL {
    return URL(string: "https://api.openweathermap.org/data/2.5/find?q=\(name)&units=metric&appid=adba724c1b24f0ac1891014c813065c8")!
}
