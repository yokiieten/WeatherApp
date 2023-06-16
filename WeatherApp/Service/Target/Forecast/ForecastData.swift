//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Sahassawat on 15/6/2566 BE.
//

import Foundation

struct ForecastDataResponse: Codable {
    let list: [List]?
    let city: City?
}

struct List: Codable {
    let main: Main?
    let weather: [WeatherDescription]?
    let dt_txt: String?
}

struct City: Codable {
    let id: Int?
    let name: String?
}
