//
//  WeatherPresenter.swift
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

protocol WeatherPresentationLogic {
  func presentWeatherByCity(response: Weather.GetWeather.Response)
  func presentFahrenheit(response: Weather.CalulateFahrenheit.Response)
}

class WeatherPresenter: WeatherPresentationLogic
{
  weak var viewController: WeatherDisplayLogic?
  
  // MARK: Do something
  
  func presentWeatherByCity(response: Weather.GetWeather.Response) {
      typealias ViewModel = Weather.GetWeather.ViewModel
      let viewModel: ViewModel
      switch response.result {
      case .loading:
          viewModel = ViewModel(content: .loading)
      case .success(let data):
          let id = unwrapped(data.weather?.first?.id, with: 0)
          let temperature = unwrapped(data.main?.temp, with: 0.0)
          let humidity = unwrapped(data.main?.humidity, with: 0)
          let name = unwrapped(data.name, with: "")
          if id == 0 {
              viewModel = ViewModel(content: .empty)
          } else {
              let weatherViewModel = WeatherModel(conditionId: id, cityName: name, temperature: temperature, humidity: humidity)
              viewModel = ViewModel(content: .success(data: weatherViewModel))
          }
      case .failure(let error):
          viewModel = ViewModel(content: .error(error: error))
      }
      viewController?.displayWeather(viewModel: viewModel)
  }
    
    func presentFahrenheit(response: Weather.CalulateFahrenheit.Response) {
        let fahrenheit = String(format: "%.1f", response.resultFahrenheit)
        viewController?.displayFahrenheit(viewModel: .init(resultFahrenheit: fahrenheit))
    }
}
