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

protocol ForeCastPresentationLogic
{
  func presentSomething(response: ForeCast.Something.Response)
}

class ForeCastPresenter: ForeCastPresentationLogic
{
  weak var viewController: ForeCastDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ForeCast.Something.Response)
  {
    let viewModel = ForeCast.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
