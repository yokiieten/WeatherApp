//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Sahassawat on 15/6/2566 BE.
//

import Foundation

struct WeatherDataResponse: Codable {
    let name: String?
    let main: Main?
    let coord: Coord?
    let weather: [WeatherDescription]?
}

struct Main: Codable {
    let temp: Double?
    let humidity: Int?
}

struct WeatherDescription: Codable {
    let description: String?
    let id: Int?
}

struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}
