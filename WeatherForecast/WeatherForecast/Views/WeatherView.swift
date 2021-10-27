//
//  WeatherView.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//
import Foundation
import SwiftUI

struct WeatherView: View {
    var city: City
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    init(city: City) {
        self.city = city
        self.weatherViewModel = WeatherViewModel(city: city)
    }
    
    var body: some View {
        VStack() {
            Text(city.name)
                .font(.title)
                
            Divider()
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(weatherViewModel.days) { weather in
                        DayColumn(weather: weather).onTapGesture {
                            weatherViewModel.selectDay(weather: weather)
                        }
                    }
                }
            }.padding()
            
            Divider()
                .padding(.horizontal)
            
            WeatherInformation(weatherViewModel: weatherViewModel)
            
            Spacer()
        }
    }
}

struct DayColumn: View {
    var weather: Day
    
    var body: some View {
        VStack {
            Text("\(weather.getDate())")
                .tracking(2.0)
                .foregroundColor(weather.isSelected ? .blue : .primary)
                .padding(.bottom, 1.0)
            Image(systemName: "sun.max").foregroundColor(.yellow).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }
        .padding(.horizontal, 5.0)
    }
}

struct WeatherInformation: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        let day = weatherViewModel.getSelectedDay()
        let weather = day!.weather
        
        Text("\(day!.getDate())")
        Text("Day Temp: \(weather.temp.day) Min Temp: \(weather.temp.min) Max Temp: \(weather.temp.max)")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(city: City(name: "Odense", coord: Coord(lat: 1.2, lon: 2.1)))
    }
}
