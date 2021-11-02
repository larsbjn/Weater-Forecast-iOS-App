//
//  APICaller.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 27/10/2021.
//

import Foundation

func JSONConvert<T: Codable>(data: Data) -> T? {
    var result: T?
    do {
        result = try JSONDecoder().decode(T.self, from: data)
    }
    catch {
        print("Failed to convert \(error.localizedDescription)")
    }
    return result
}

func CallAPI<T: Codable>(url: URL, action: @escaping (_ actionParam: T) -> Void) {
    URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
        guard let data = data, error == nil else {
            print(error!)
            return
        }
        
        let result: T? = JSONConvert(data: data)
        
        guard let parsed = result else {
            print("Error parsing data to JSON")
            return
        }
        DispatchQueue.main.async {
            action(parsed)
        }
    }).resume()
}

func CallFindCityAPI(name: String, action: @escaping (_ city: CityList) -> Void) {
    CallAPI(url: FindCityURL(name: name), action: action)
}

func CallWeatherForecastAPI(coord: Coord, action: @escaping (_ weatherWeek: WeatherWeek) -> Void) {
    CallAPI(url: WeatherForecastUrl(coord: coord), action: action)
}

func CallCityNameByCoordinatesAPI(coord: Coord, action: @escaping (_ cityByCoordinate: [CityByCoordinate]) -> Void) {
    CallAPI(url: CityNameByCoordinates(coord: coord), action: action)
}

struct CityByCoordinate: Codable {
    let name: String
    let lat: Float
    let lon: Float
}

private func FindCityURL(name: String) -> URL {
    return URL(string: "https://api.openweathermap.org/data/2.5/find?q=\(name)&units=metric&appid=f8deab550d78a36251a76a5a6a60a065")!
}

private func WeatherForecastUrl(coord: Coord) -> URL {
    return URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(coord.lat)&lon=\(coord.lon)&exclude=current,minutely,alerts&units=metric&appid=f8deab550d78a36251a76a5a6a60a065")!
}

private func CityNameByCoordinates(coord: Coord) -> URL {
    return URL(string:
        "https://api.openweathermap.org/geo/1.0/reverse?lat=\(coord.lat)&lon=\(coord.lon)&limit=1&appid=f8deab550d78a36251a76a5a6a60a065")!
}
