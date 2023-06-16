//
//  AIMActivityIndicatorManager+Window.swift
//  ActivityIndicatorManager
//
//  Created by Dimitar V. Petrov on 22.11.19.
//  Copyright © 2019 Upnetix. All rights reserved.
//

import Foundation

extension AIMActivityIndicatorManager: WindowActivityIndicatorManager {
    
    open var isIndicatorShown: Bool {
        return numberOfObservers > 0
    }
    
    open func shouldShowIndicator() {
        DispatchQueue.main.async { [self] in
            numberOfObservers += 1
            showIndicator()
        }
    }
    
    open func shouldHideIndicator() {
        //`numberOfObservers` Should NOT be less than(<) 0
        DispatchQueue.main.async { [self] in
            guard isIndicatorShown else { return }
            
            numberOfObservers -= 1
            hideIndicator()
        }
    }
    
    open func forceHideIndicator() {
        DispatchQueue.main.async { [self] in
            numberOfObservers = 0
            isMinimumTimeElapsed = true
            hideIndicator()
        }
    }
    
}
