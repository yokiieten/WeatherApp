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
    var router: (WeatherRoutingLogic & WeatherDataPassing)?
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var fahrenheitStackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var celsiusStackView: UIStackView!
    @IBOutlet weak var convertButton: UIButton!
    
    
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
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(pushToForeCast))]
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc func pushToForeCast() {
        router?.routeToForecast()
    }
    
    
    @IBAction func tapSearchButton(_ sender: Any) {
        if let city = searchTextField.text {
            let request = Weather.GetWeather.Request(city: city)
            interactor?.getWeatherByCity(request: request)
        }
        
        searchTextField.text = ""
    }
    
    @IBAction func tapConvert(_ sender: Any) {
        guard let celsius = temperatureLabel.text else { return }
        interactor?.calculateFahrenheit(request: .init(celsius: celsius))
    }
    
    private func setHidden(value: Bool) {
        errorLabel.isHidden = !value
        celsiusStackView.isHidden = value
        fahrenheitStackView.isHidden = value
        cityLabel.isHidden = value
        conditionImageView.isHidden = value
        convertButton.isHidden = value
    }
    
    private func showAlert(localizedDescription: String) {
        let alert = UIAlertController(title: "Error", message: localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension WeatherViewController: WeatherDisplayLogic {
    
    func displayWeather(viewModel: Weather.GetWeather.ViewModel) {
        switch viewModel.content {
            
        case .loading: AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
        case .empty:
            AIMActivityIndicatorManager.sharedInstance.forceHideIndicator()
            setHidden(value: true)
            interactor?.resetValue()
        case .success(data: let data):
            AIMActivityIndicatorManager.sharedInstance.forceHideIndicator()
            setHidden(value: false)
            cityLabel.text = data.cityName
            temperatureLabel.text = data.temperatureString
            conditionImageView.image = UIImage(systemName: data.conditionName)
            fahrenheitStackView.isHidden = true
        case .error(error: let error):
            setHidden(value: true)
            showAlert(localizedDescription: error.localizedDescription)
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
