//
//  TargetType.swift
//  The RickandMortyAPI
//
//  Created by Sahassawat on 15/2/2565 BE.
//

import Moya

extension TargetType {
    func requestJSONTask(_ parameters: Encodable) -> Task {
        Task.requestJSONEncodable(parameters)
    }
    
    var baseURL: URL {
        URL(string: "https://api.openweathermap.org")!
    }
    
    var sampleData: Data {
        return Data()
    }
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
