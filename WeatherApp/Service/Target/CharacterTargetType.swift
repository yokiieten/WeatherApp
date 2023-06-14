//
//  CharacterTargetType.swift
//  The RickandMortyAPI
//
//  Created by Sahassawat on 15/2/2565 BE.
//

import Moya

struct Character : Decodable {
    let id: Int
    let name: String
    let status : String
    let species : String
    let gender : String
    let image : String
    let created : String
}

enum CharacterTargetType {
    case getAllCharacter(page: String)
    case searchCharacter(characterId: String)
}

extension CharacterTargetType: TargetType {
    var path: String {
        switch self {
        case .getAllCharacter(_):
            return "/api/character/"
        case .searchCharacter(let id):
            return "/api/character/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getAllCharacter(_):
            return .get
        case .searchCharacter(_):
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getAllCharacter(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case .searchCharacter(characterId: _):
            return .requestPlain
        }
    }
}

