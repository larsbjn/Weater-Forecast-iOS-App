//
//  WeatherView.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//
import Foundation
import SwiftUI

struct WeatherView: View {

    @ObservedObject var weatherViewModel: WeatherViewModel
    
    init(city: City) {
        self.weatherViewModel = WeatherViewModel(city: city)
    }
    
    var body: some View {
        let container = List {
            VStack() {
                Text(weatherViewModel.getCityName())
                    .font(.title)
                WeatherInformation(weatherViewModel: weatherViewModel)
            }.frame(maxWidth: .infinity, alignment: .center)
                .padding(15)
            
            HourlyWeather(weatherViewModel: weatherViewModel)
                
            DailyWeather(weatherViewModel: weatherViewModel)
        }.navigationBarTitleDisplayMode(.inline)
        if #available(iOS 15.0, *) {
            container.refreshable {
                weatherViewModel.getWeatherData()
            }
        }
    }
}

struct WeatherInformation: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        let hour = weatherViewModel.getCurrentHourWeather()
        let dayWeather = weatherViewModel.getCurrentDay()?.dayWeather
        
        Text(String(format: "%.1f°", hour!.temp)).font(.system(size: 60))
        Text("\(hour!.weather[0].description.capitalized)")
        Text(String(format: "H: %.1f° L: %.1f°", dayWeather!.temp.max, dayWeather!.temp.min))
    }
}

struct HourlyWeather: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(weatherViewModel.hourly) { hour in
                    HourlyColumn(hour: hour)
                }
            }
        }.padding()
    }
}

struct HourlyColumn: View {
    var hour: HourWeather
    
    var body: some View {
        let icon = hour.weather[0].getIcon()
        VStack {
            Text("\(hour.getHour())")
                .tracking(2.0)
                .padding(.bottom, 1.0)
            Icon(icon: icon)
            Text(String(format: "%.1f°", hour.temp))
        }
        .padding(.horizontal, 5.0)
    }
}



struct DailyWeather: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            ForEach(weatherViewModel.days) { day in
                DayColumn(day: day)
            }
        }
    }
}

struct DayColumn: View {
    var day: Day
    
    var body: some View {
        let icon = day.dayWeather.weather[0].getIcon()
        HStack(spacing: 30.0) {
            Text("\(day.getDate())")
                .tracking(2.0)
                .padding(.bottom, 1.0)
            Icon(icon: icon)
            Text(String(format: "H: %.1f° L: %.1f°", day.dayWeather.temp.max, day.dayWeather.temp.min))
        }
        .padding(.horizontal, 5.0)
    }
}

struct Icon: View {
    let icon: Weather.Icon
    
    var body: some View {
        let image = Image(systemName: icon.name)
            .frame(width: 50.0, height: 50.0)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        if #available(iOS 15.0, *) {
            image.symbolRenderingMode(.palette)
                 .foregroundStyle(icon.primaryColor, icon.secondaryColor)
        } else {
            // Fallback on earlier versions
            image.foregroundColor(icon.primaryColor)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(city: City(name: "Odense", coord: Coord(lat: 1.2, lon: 2.1)))
    }
}
