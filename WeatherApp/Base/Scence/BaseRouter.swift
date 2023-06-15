//
//  BaseRouter.swift
//  WeatherApp
//
//  Created by Sahassawat on 15/6/2566 BE.
//

import UIKit

enum Storyboard: String {

    case Forecast = "ForeCastViewController"

    var viewcontrollerId: String {
        return rawValue
    }
    
    var name: String {
        return String(describing: self)
    }
}

class BaseRouter {
    
    internal weak var viewController: UIViewController?
    private var onPushReceivedNotification: NSObjectProtocol?
    
    init() {}
    
    func backToPrevious() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func backToFirstView(){
        guard let viewControllers = viewController?.navigationController?.viewControllers else { return }
        guard let firstViewController = viewControllers.first else { return }
        viewController?.navigationController?.popToViewController(firstViewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        let navigationControll = UINavigationController(rootViewController: viewController)
        navigationControll.modalPresentationStyle = .fullScreen
        self.viewController?.present(navigationControll, animated: true, completion: nil)
    }
    
    func present(viewController: UIViewController, animated: Bool) {
        let navigationControll = UINavigationController(rootViewController: viewController)
        navigationControll.modalPresentationStyle = .fullScreen
        self.viewController?.present(navigationControll, animated: animated, completion: nil)
    }
    
    func present(viewController: UIViewController, modalPresentationStyle: UIModalPresentationStyle, animated: Bool) {
        let navigationControll = UINavigationController(rootViewController: viewController)
        navigationControll.modalPresentationStyle = modalPresentationStyle
        self.viewController?.present(navigationControll, animated: animated, completion: nil)
    }
    
    func pushViewController(_ viewController: UIViewController) {
        guard self.viewController?.navigationController != nil else {
            viewController.modalPresentationStyle = .fullScreen
            self.viewController?.present(viewController, animated: true, completion: nil)
            return
        }
//        viewController.navigationItem.hidesBackButton = true
        pushViewController(viewController, animated: true)
    }
    
    func pushViewControllerWithHidesBackButton(_ viewController: UIViewController) {
        guard self.viewController?.navigationController != nil else {
            viewController.modalPresentationStyle = .fullScreen
            self.viewController?.present(viewController, animated: true, completion: nil)
            return
        }
        viewController.navigationItem.hidesBackButton = true
        pushViewController(viewController, animated: true)
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let navigationController = self.viewController?.navigationController else {
            viewController.modalPresentationStyle = .fullScreen
            self.viewController?.present(viewController, animated: animated, completion: nil)
            return
        }
        
        guard let directNavigation = viewController as? UINavigationController else {
            viewController.modalPresentationStyle = .fullScreen
            navigationController.pushViewController(viewController, animated: animated)
            return
        }
        
        directNavigation.modalPresentationStyle = .fullScreen
        self.viewController?.present(directNavigation, animated: animated, completion: nil)
    }
    
    func getViewController<VC: UIViewController>(storyboard: Storyboard, expectedVC: VC.Type) -> VC {
        return UIStoryboard(name: storyboard.name, bundle: nil)
            .instantiateViewController(withIdentifier: storyboard.viewcontrollerId) as! VC
    }
    
    func popToViewController(ofClass: AnyClass) {
        viewController?.navigationController?.popToViewController(ofClass: ofClass)
    }
    
}

