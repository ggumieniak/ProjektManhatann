//
//  WeatherView.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 29/06/2021.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    var body: some View {
        ZStack {
            if viewModel.isSharedLocation {
                VStack {
                    if let current = viewModel.currentWeather {
                        WeatherDetail(imageName: viewModel.getImageProperName(id: current.weather[0].id), cityName: current.name, description: current.weather[0].description, wind: "\(current.wind.speed)", temperature: "\(current.main.temp)", humidity: "\(current.main.humidity)")
                    } else {
                        Text("Loading Data...")
                    }
                    Divider()
                    if let weatherList = viewModel.dailyWeather?.daily {
                        ScrollView {
                            ForEach(0..<weatherList.count) { id in
                                WeatherDetail(imageName: viewModel.getImageProperName(id: weatherList[id].weather[0].id), cityName: "", description: weatherList[id].weather[0].description, wind: "\(weatherList[id].wind_speed)", temperature: "\(weatherList[id].temp.day)", humidity: "\(weatherList[id].humidity)").padding(.top)
                            }
                        }
                    } else {
                        Text("Loading Data...")
                    }
                }.onAppear(perform: {
                    self.viewModel.fetchData()
                    self.viewModel.checkIsUserShareTheAuthorization()
                })
            } else {
                Text("You don't share the location")
            }
        }.onAppear(perform: {
            self.viewModel.checkIsUserShareTheAuthorization()
        })
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
