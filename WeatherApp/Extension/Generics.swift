//
//  Generics.swift
//  WeatherApp
//
//  Created by Sahassawat on 14/6/2566 BE.
//

import Foundation

public func unwrapped<T>(_ wrapped: T?, with castValue: T) -> T {
    if let unwrapped = wrapped {
        return unwrapped
    } else {
        return castValue
    }
}

public enum GlobalResult<T> {
    case success(result: T)
    case failure(error: Error)
}

public enum Result<T> {
    case success(result: T)
    case failure(error: Error)
}

public enum UserResult<T> {
    case loading
    case success(result: T)
    case failure(error: Error)
}

public enum Content<T, E: Error> {
    case loading
    case empty
    case success(data: T)
    case error(error: Error)
}

public struct BaseViewModelError<E: Error> {
    let title: String
    let message: String
    let urlUnlockPin: String
    let `case`: E

    init(title: String, message: String, urlUnlockPin: String = "", case: E) {
        self.title = title
        self.message = message
        self.urlUnlockPin = urlUnlockPin
        self.case = `case`
    }
}
