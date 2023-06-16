//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Sahassawat on 14/6/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WeatherBusinessLogic {
    func getWeatherByCity(request: Weather.GetWeather.Request)
    func calculateFahrenheit(request: Weather.CalulateFahrenheit.Request)
}

protocol WeatherDataStore {
    var lon: Double? { get set }
    var lat: Double? { get set }
}

class WeatherInteractor: WeatherBusinessLogic, WeatherDataStore {
    var presenter: WeatherPresentationLogic?
    var worker: WeatherWorker?
    var apiKey = CoreManager.sharedInstance.apiKey
    var lon: Double?
    var lat: Double?
    
    // MARK: Do something
    
    func getWeatherByCity(request: Weather.GetWeather.Request) {
        
        worker?.fetchWeather(city: request.city, apiKey: apiKey, completion: { result in
            switch result {
            case .success(let result):
                if let response = result {
                    self.lat = result?.coord?.lat ?? 0.0
                    self.lon = result?.coord?.lon ?? 0.0
                    self.presenter?.presentWeatherByCity(response: .init(result: .success(result: response)))
                    
                }
            case .failure(error: let error):
                self.presenter?.presentWeatherByCity(response: .init(result: .failure(error: error)))
            }
        })
    }
    
    func calculateFahrenheit(request: Weather.CalulateFahrenheit.Request) {
        guard let celsius = Double(request.celsius) else { return  }
        let fahrenheit = (celsius * 1.8) + 32
        presenter?.presentFahrenheit(response: .init(resultFahrenheit: fahrenheit))
        
    }
}
