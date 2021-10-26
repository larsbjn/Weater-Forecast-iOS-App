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
        NavigationView {
            List {
                ForEach(cityViewModel.cities) { city in
                    NavigationLink(destination: WeatherView(city: city)) {
                        Text(city.name)
                    }
                }.onDelete(perform: { indexSet in
                    cityViewModel.deleteCity(indexSet)
                })
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
            .navigationTitle("Cities")
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
