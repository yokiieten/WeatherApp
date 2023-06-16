//
//  ForeCastPresenter.swift
//  WeatherApp
//
//  Created by Sahassawat on 15/6/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ForeCastPresentationLogic {
    func presentForecast(response: ForeCast.GetForeCast.Response)
}

class ForeCastPresenter: ForeCastPresentationLogic {
    weak var viewController: ForeCastDisplayLogic?
    
    // MARK: Do something
    
    func presentForecast(response: ForeCast.GetForeCast.Response) {
        typealias ViewModel = ForeCast.GetForeCast.ViewModel
        let viewModel: ViewModel
        switch response.result {
            
        case .loading: viewModel = ViewModel(content: .loading)
        case .success(result: let result):
            var weatherListViewModel = [WeatherModel]()
            guard let lists = result.list else { return  }
            for list in lists {
                let id = unwrapped(list.weather?.first?.id, with: 0)
                let temperature = unwrapped(list.main?.temp, with: 0.0)
                let name = unwrapped(result.city?.name, with: "non")
                let date = unwrapped(list.dt_txt, with: "-")
                let weatherViewModel = WeatherModel(conditionId: id, cityName: name, temperature: temperature, date: date)
                weatherListViewModel.append(weatherViewModel)
            }
            viewModel = ViewModel(content: .success(data: weatherListViewModel))
        case .failure(error: let error):
            viewModel = ViewModel(content: .error(error: .init(title: error.localizedDescription, message: "", case: error)))
        }
        viewController?.displayForecast(viewModel: viewModel)
    }
}
