//
//  WaterTargetType.swift
//  WeatherApp
//
//  Created by Sahassawat on 15/6/2566 BE.
//

import Moya

enum WeatherTargetType {
    case getWeatherByCityName(city: String, apiKey: String)
    case getForecast(lat: Double, lon: Double, apiKey: String)
}

extension WeatherTargetType: TargetType {
    var path: String {
        switch self {
        case .getWeatherByCityName:
            return "/data/2.5/weather"
        case .getForecast:
            return "/data/2.5/forecast"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getWeatherByCityName:
            return .get
        case .getForecast:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getWeatherByCityName(let city, let apiKey):
            return .requestParameters(parameters: ["q": city,
                                                   "units": "metric",
                                                   "appid": apiKey], encoding: URLEncoding.queryString)
        case .getForecast(let lat, let lon, let apiKey):
            return .requestParameters(parameters: ["lat": lat,
                                                   "lon": lon,
                                                   "units": "metric",
                                                   "appid": apiKey], encoding: URLEncoding.queryString)
        }
    }
}

