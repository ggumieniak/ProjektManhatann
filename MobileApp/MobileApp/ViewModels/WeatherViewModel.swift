//
//  WeatherViewModel.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 29/06/2021.
//

import Foundation
import CoreLocation.CLLocation
import Combine

class WeatherViewModel: ObservableObject {
    private let locationManager = LocationManager()
    private let didChange = PassthroughSubject<Void,Never>()
    @Published var isSharedLocation: Bool = false
    @Published var currentWeather: Current? {
        didSet {
            didChange.send(())
        }
    }
    @Published var dailyWeather: DailyResponse? {
        didSet {
            didChange.send(())
        }
    }
    func fetchData() {
        guard let location = locationManager.location else {
            return
        }
        var url = prepareLocationURL(at: .current, in: location)
        var request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            do {
                let currentWeather = try JSONDecoder().decode(Current.self, from: data)
                DispatchQueue.main.async {
                    self.currentWeather = currentWeather
                }
            } catch {
                print(error)
            }
        }.resume()
        url = prepareLocationURL(at: .daily, in: location)
        request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            do {
                let response = try JSONDecoder().decode(DailyResponse.self, from: data)
                DispatchQueue.main.async {
                    self.dailyWeather = response
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    private func prepareLocationURL(at query:Queries, in location: CLLocation) -> URL {
        switch query
        {
        case .current:
            return URL(string: "\(Keys.OpewWeather.weatherCurrentURL)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)")!
        case .daily:
            return URL(string: "\(Keys.OpewWeather.weatherDailyURL)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)")!
        }
    }
    
    private enum Queries {
        case current, daily
    }
    func checkIsUserShareTheAuthorization() {
        isSharedLocation =  locationManager.checkIsUserShareTheAuthorization()
    }
    
    func getImageProperName(id code: Int) -> String {
        switch code {
        case 200..<299:
            return "cloud.bolt.rain.fill"
        case 300..<399:
            return "cloud.drizzle.fill"
        case 500..<599:
            return "cloud.rain.fill"
        case 600..<699:
            return "cloud.snow.fill"
        case 700..<799:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "xmark.octagon.fill"
        }
    }
}
