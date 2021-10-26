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
    @ObservedObject var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        VStack() {
            Text(city.name)
                .font(.title)
                
            Divider()
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(weatherViewModel.weathers) { weather in
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
    var weather: Weather
    
    var body: some View {
        VStack {
            Text("\(weather.getDay())/\(weather.getMonth())")
                .tracking(/*@START_MENU_TOKEN@*/2.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(weather.isSelected ? .blue : .black)
            Image("wi-day-sunny")
        }
        .padding(.horizontal, 12.0)
    }
}

struct WeatherInformation: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        let weather = weatherViewModel.getSelectedDay()
        
        Text((weather?.getDay())!)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(city: City(id: UUID(), name: "Odense"))
    }
}
