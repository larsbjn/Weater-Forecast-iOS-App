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
                    ForEach(weatherViewModel.days) { day in
                        DayColumn(day: day).onTapGesture {
                            weatherViewModel.selectDay(weather: day)
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
    var day: Day
    
    var body: some View {
        let icon = day.dayWeather.weather[0].getIcon()
        VStack {
            Text("\(day.getDate())")
                .tracking(2.0)
                .foregroundColor(day.isSelected ? .blue : .primary)
                .padding(.bottom, 1.0)
            if #available(iOS 15.0, *) {
                Image(systemName: icon.name)
                    .frame(width: 50.0, height: 50.0)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(icon.primaryColor, icon.secondaryColor)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            } else {
                // Fallback on earlier versions
                Image(systemName: icon.name)
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(icon.primaryColor)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
        }
        .padding(.horizontal, 5.0)
    }
}

struct WeatherInformation: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        let day = weatherViewModel.getSelectedDay()
        let dayWeather = day!.dayWeather
        let hourlyWeather = day!.getCurrentHourWeather()
        
        Text(String(format: "%.1f°", hourlyWeather!.temp)).font(.system(size: 60))
        Text("\(dayWeather.weather[0].description.capitalized)")
        Text(String(format: "H: %.1f° L: %.1f°", dayWeather.temp.max, dayWeather.temp.min))
        Text("\(day!.hourlyWeather.count)")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(city: City(name: "Odense", coord: Coord(lat: 1.2, lon: 2.1)))
    }
}
