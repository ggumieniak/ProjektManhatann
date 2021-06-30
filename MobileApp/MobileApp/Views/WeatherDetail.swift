//
//  Weather.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 29/06/2021.
//

import SwiftUI

struct WeatherDetail: View {
    @ObservedObject var viewModel: WeatherDetailViewModel
    var body: some View {
        HStack {
            Image(systemName: viewModel.imageName)
                .aspectRatio(contentMode: .fill)
                .font(.largeTitle)
                .frame(maxWidth: 100, maxHeight: 100)
            VStack(alignment: .leading) {
                Text(viewModel.cityName)
                    .font(.largeTitle)
                Text(viewModel.description)
                    .font(.body)
                HStack {
                    HStack {
                        Image(systemName: "wind")
                        Text("\(viewModel.wind) km/h")
                    }
                    HStack {
                        Image(systemName: "thermometer")
                        Text("\(viewModel.temperature)℃")
                    }
                    HStack {
                        Image(systemName: "drop.fill")
                        Text("\(viewModel.humidity)%")
                    }
                }
            }
        }
    }
}

struct Weather_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetail(imageName: "sun.max.fill", cityName: "Stalowa Wola", description: "Opis", wind: "4,14 km/h", temperature: "36.6", humidity: "66.6%")
    }
}

extension WeatherDetail {
    init(imageName: String, cityName: String, description: String, wind: String, temperature: String, humidity: String) {
        viewModel = WeatherDetailViewModel(imageName: imageName, cityName: cityName, description: description, wind: wind, temperature: temperature, humidity: humidity)
    }
}
