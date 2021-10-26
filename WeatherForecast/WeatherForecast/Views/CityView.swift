//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Lars Jørgensen on 14/10/2021.
//

import SwiftUI

struct CityView: View {
    @StateObject var cityViewModel = CityViewModel()
    @State private var cityName: String = ""
    
    var body: some View {
        
        List {
            ForEach(cityViewModel.cities) { city in
                HStack {
                    Text(city.name)
                    Button("Delete") {
                        cityViewModel.removeCity(city.name)
                    }
                    .foregroundColor(.red)
                }
            }
            HStack {
                TextField("City name", text: $cityName)
                Button("Add") {
                    guard cityName != "" else { return }
                    cityViewModel.addCity(cityName)
                    cityName = ""
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct CityRow: View {
    var city: City
    
    var body: some View {
        Text(city.name)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
