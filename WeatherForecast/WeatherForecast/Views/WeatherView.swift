//
//  WeatherView.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 26/10/2021.
//

import SwiftUI

struct WeatherView: View {
    var city: City
    var body: some View {
        Text(city.name)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Text("temp")
    }
}
