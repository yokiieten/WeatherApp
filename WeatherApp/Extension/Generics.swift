//
//  Generics.swift
//  WeatherApp
//
//  Created by Sahassawat on 14/6/2566 BE.
//

import Foundation

enum Results<T> {
    case success(content: T)
    case failure(error: Error)
}
