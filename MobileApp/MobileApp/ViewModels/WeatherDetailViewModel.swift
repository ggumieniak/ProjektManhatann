//
//  WeatherDetailViewModel.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 29/06/2021.
//

import Foundation

class WeatherDetailViewModel: ObservableObject {
    @Published var imageName: String
    @Published var cityName: String
    @Published var description: String
    @Published var wind: String
    @Published var temperature: String
    @Published var humidity: String
    
    init(imageName: String, cityName: String, description: String, wind: String, temperature: String, humidity: String) {
        self.imageName = imageName
        self.cityName = cityName
        self.description = description
        self.wind = wind
        self.temperature = temperature
        self.humidity = humidity
    }
}
