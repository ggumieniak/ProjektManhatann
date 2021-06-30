//
//  OpenWeatherResponse.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 29/06/2021.
//

import Foundation

struct OpenWeatherDailyResponse: Decodable {
    let daily: [Daily]
}

struct Current: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Wind: Decodable {
    let speed: Double
}

struct DailyResponse: Decodable {
    let daily: [Daily]
}

struct Daily: Decodable {
    let dt: Int
    let temp: Temp
    let humidity: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct Temp: Decodable {
    let day: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}

