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

func CallFindCityAPI(name: String, action: @escaping (_ city: City) -> Void) {
    CallAPI(url: FindCityURL(name: name), action: action)
}

func CallWeatherForecastAPI(coord: Coord, action: @escaping (_ weatherWeek: WeatherWeek) -> Void) {
    //CallAPI(url: WeatherForecastUrl(coord: coord), action: action)
    
    let temp = """
    {
        "lat": 33.44,
        "lon": -94.04,
        "timezone": "America/Chicago",
        "timezone_offset": -18000,
        "daily": [
            {
                "dt": 1635354000,
                "sunrise": 1635337839,
                "sunset": 1635377347,
                "moonrise": 1635396120,
                "moonset": 1635360300,
                "moon_phase": 0.72,
                "temp": {
                    "day": 21.13,
                    "min": 13.78,
                    "max": 21.55,
                    "night": 13.78,
                    "eve": 19.92,
                    "morn": 20.59
                },
                "feels_like": {
                    "day": 21.65,
                    "night": 13.28,
                    "eve": 20.21,
                    "morn": 20.95
                },
                "pressure": 1000,
                "humidity": 90,
                "dew_point": 19.43,
                "wind_speed": 6.87,
                "wind_deg": 253,
                "wind_gust": 14.65,
                "weather": [
                    {
                        "id": 503,
                        "main": "Rain",
                        "description": "very heavy rain",
                        "icon": "10d"
                    }
                ],
                "clouds": 98,
                "pop": 1,
                "rain": 30.96,
                "uvi": 3.34
            },
            {
                "dt": 1635440400,
                "sunrise": 1635424291,
                "sunset": 1635463687,
                "moonrise": 0,
                "moonset": 1635449280,
                "moon_phase": 0.75,
                "temp": {
                    "day": 13.79,
                    "min": 12.33,
                    "max": 14.9,
                    "night": 14.28,
                    "eve": 13.45,
                    "morn": 14.9
                },
                "feels_like": {
                    "day": 12.66,
                    "night": 13.15,
                    "eve": 12.37,
                    "morn": 13.75
                },
                "pressure": 1002,
                "humidity": 55,
                "dew_point": 5.06,
                "wind_speed": 10.65,
                "wind_deg": 301,
                "wind_gust": 21.28,
                "weather": [
                    {
                        "id": 804,
                        "main": "Clouds",
                        "description": "overcast clouds",
                        "icon": "04d"
                    }
                ],
                "clouds": 100,
                "pop": 0.04,
                "uvi": 0.69
            },
            {
                "dt": 1635526800,
                "sunrise": 1635510744,
                "sunset": 1635550027,
                "moonrise": 1635486060,
                "moonset": 1635538020,
                "moon_phase": 0.78,
                "temp": {
                    "day": 13.27,
                    "min": 10.38,
                    "max": 15.31,
                    "night": 10.38,
                    "eve": 13.86,
                    "morn": 13.13
                },
                "feels_like": {
                    "day": 12.04,
                    "night": 9.46,
                    "eve": 12.79,
                    "morn": 11.91
                },
                "pressure": 1012,
                "humidity": 53,
                "dew_point": 4.03,
                "wind_speed": 8.4,
                "wind_deg": 312,
                "wind_gust": 18.76,
                "weather": [
                    {
                        "id": 804,
                        "main": "Clouds",
                        "description": "overcast clouds",
                        "icon": "04d"
                    }
                ],
                "clouds": 100,
                "pop": 0,
                "uvi": 2.1
            },
            {
                "dt": 1635613200,
                "sunrise": 1635597196,
                "sunset": 1635636370,
                "moonrise": 1635576120,
                "moonset": 1635626580,
                "moon_phase": 0.81,
                "temp": {
                    "day": 19.47,
                    "min": 8.06,
                    "max": 21.27,
                    "night": 12.17,
                    "eve": 14.85,
                    "morn": 8.46
                },
                "feels_like": {
                    "day": 18.6,
                    "night": 10.98,
                    "eve": 13.77,
                    "morn": 6.44
                },
                "pressure": 1012,
                "humidity": 43,
                "dew_point": 6.74,
                "wind_speed": 4.32,
                "wind_deg": 313,
                "wind_gust": 11.56,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ],
                "clouds": 0,
                "pop": 0,
                "uvi": 4.62
            },
            {
                "dt": 1635699600,
                "sunrise": 1635683650,
                "sunset": 1635722713,
                "moonrise": 1635666300,
                "moonset": 1635714900,
                "moon_phase": 0.84,
                "temp": {
                    "day": 22.36,
                    "min": 9.29,
                    "max": 23.91,
                    "night": 14.79,
                    "eve": 17.37,
                    "morn": 9.29
                },
                "feels_like": {
                    "day": 21.49,
                    "night": 13.76,
                    "eve": 16.36,
                    "morn": 9.29
                },
                "pressure": 1016,
                "humidity": 32,
                "dew_point": 5.13,
                "wind_speed": 2.47,
                "wind_deg": 103,
                "wind_gust": 2.5,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ],
                "clouds": 0,
                "pop": 0,
                "uvi": 4.48
            },
            {
                "dt": 1635786000,
                "sunrise": 1635770103,
                "sunset": 1635809058,
                "moonrise": 1635756600,
                "moonset": 1635803160,
                "moon_phase": 0.88,
                "temp": {
                    "day": 22.72,
                    "min": 11.52,
                    "max": 24.44,
                    "night": 15.84,
                    "eve": 18.38,
                    "morn": 11.52
                },
                "feels_like": {
                    "day": 22.12,
                    "night": 15.36,
                    "eve": 17.71,
                    "morn": 10.69
                },
                "pressure": 1022,
                "humidity": 41,
                "dew_point": 8.99,
                "wind_speed": 3.37,
                "wind_deg": 128,
                "wind_gust": 4.14,
                "weather": [
                    {
                        "id": 500,
                        "main": "Rain",
                        "description": "light rain",
                        "icon": "10d"
                    }
                ],
                "clouds": 65,
                "pop": 0.37,
                "rain": 0.16,
                "uvi": 5
            },
            {
                "dt": 1635872400,
                "sunrise": 1635856557,
                "sunset": 1635895404,
                "moonrise": 1635846900,
                "moonset": 1635891480,
                "moon_phase": 0.92,
                "temp": {
                    "day": 19.04,
                    "min": 15.06,
                    "max": 19.13,
                    "night": 16.23,
                    "eve": 17.28,
                    "morn": 15.46
                },
                "feels_like": {
                    "day": 19.19,
                    "night": 16.42,
                    "eve": 17.54,
                    "morn": 15.52
                },
                "pressure": 1023,
                "humidity": 84,
                "dew_point": 16.44,
                "wind_speed": 2.64,
                "wind_deg": 146,
                "wind_gust": 7.57,
                "weather": [
                    {
                        "id": 500,
                        "main": "Rain",
                        "description": "light rain",
                        "icon": "10d"
                    }
                ],
                "clouds": 99,
                "pop": 0.87,
                "rain": 5.97,
                "uvi": 5
            },
            {
                "dt": 1635958800,
                "sunrise": 1635943011,
                "sunset": 1635981751,
                "moonrise": 1635937380,
                "moonset": 1635979860,
                "moon_phase": 0.95,
                "temp": {
                    "day": 10.33,
                    "min": 8.59,
                    "max": 15.42,
                    "night": 8.59,
                    "eve": 8.89,
                    "morn": 14.41
                },
                "feels_like": {
                    "day": 9.87,
                    "night": 6.07,
                    "eve": 6.29,
                    "morn": 14.47
                },
                "pressure": 1023,
                "humidity": 94,
                "dew_point": 9.46,
                "wind_speed": 5.07,
                "wind_deg": 45,
                "wind_gust": 10.17,
                "weather": [
                    {
                        "id": 502,
                        "main": "Rain",
                        "description": "heavy intensity rain",
                        "icon": "10d"
                    }
                ],
                "clouds": 100,
                "pop": 1,
                "rain": 52.68,
                "uvi": 5
            }
        ]
    }
    """.data(using: .utf8)
    
    var result: WeatherWeek?
    do {
        result = try JSONDecoder().decode(WeatherWeek.self, from: temp!)
    }
    catch {
        print("Failed to convert \(error.localizedDescription)")
    }

    guard let parsed = result else {
        print("Error parsing data to JSON")
        return
    }
    DispatchQueue.main.async {
        action(parsed)
    }
}

private func FindCityURL(name: String) -> URL {
    return URL(string: "https://api.openweathermap.org/data/2.5/find?q=\(name)&units=metric&appid=adba724c1b24f0ac1891014c813065c8")!
}

private func WeatherForecastUrl(coord: Coord) -> URL {
    return URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(coord.lat)&lon=\(coord.lon)&exclude=current,minutely,hourly,alerts&units=metric&appid=adba724c1b24f0ac1891014c813065c8")!
}
