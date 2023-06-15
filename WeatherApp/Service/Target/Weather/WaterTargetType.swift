//
//  WaterTargetType.swift
//  WeatherApp
//
//  Created by Sahassawat on 15/6/2566 BE.
//

import Moya

enum WeatherTargetType {
    case getWeatherByCityName(city: String, apiKey: String)
    case searchCharacter(characterId: String)
}

extension WeatherTargetType: TargetType {
    var path: String {
        switch self {
        case .getWeatherByCityName(_):
            return "/data/2.5/weather"
        case .searchCharacter(let id):
            return "/api/character/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getWeatherByCityName(_):
            return .get
        case .searchCharacter(_):
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getWeatherByCityName(let city, let apiKey):
            return .requestParameters(parameters: ["q": city,
                                                   "appid": apiKey], encoding: URLEncoding.queryString)
        case .searchCharacter(characterId: _):
            return .requestPlain
        }
    }
}

