//
//  WeatherViewController.swift
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

protocol WeatherDisplayLogic: AnyObject {
  func displayWeather(viewModel: Weather.GetWeather.ViewModel)
  func displayFahrenheit(viewModel: Weather.CalulateFahrenheit.ViewModel)
}

class WeatherViewController: UIViewController {
  var interactor: WeatherBusinessLogic?
  var router: (NSObjectProtocol & WeatherRoutingLogic & WeatherDataPassing)?
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var fahrenheitStackView: UIStackView!

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = WeatherInteractor()
    let presenter = WeatherPresenter()
    let router = WeatherRouter()
    let worker = WeatherWorker()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    interactor.worker = worker
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
      searchTextField.delegate = self
  }
    
    @IBAction func tapConvert(_ sender: Any) {
        guard let celsius = temperatureLabel.text else { return }
        interactor?.calculateFahrenheit(request: .init(celsius: celsius))
    }
    
}

extension WeatherViewController: WeatherDisplayLogic {
    
    func displayWeather(viewModel: Weather.GetWeather.ViewModel) {
        switch viewModel.content {
          
        case .loading: break
        case .empty: break
        case .success(data: let data):
            cityLabel.text = data.cityName
            temperatureLabel.text = data.temperatureString
            conditionImageView.image = UIImage(systemName: data.conditionName)
            fahrenheitStackView.isHidden = true
        case .error(error: let error):
            print(error)
        }
    }
    
    func displayFahrenheit(viewModel: Weather.CalulateFahrenheit.ViewModel) {
        fahrenheitStackView.isHidden = false
        fahrenheitLabel.text = viewModel.resultFahrenheit
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            let request = Weather.GetWeather.Request(city: city)
          interactor?.getWeatherByCity(request: request)
        }
        
        searchTextField.text = ""
        
    }
}