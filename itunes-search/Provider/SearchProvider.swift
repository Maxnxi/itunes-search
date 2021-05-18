//
//  SearchProvider.swift
//  itunes-search
//
//  Created by Maksim on 12.05.2021.
//

import Moya

enum SearchProvider: TargetType {
    
    
    
    case artistList(searchString: String, limit: Int, offset: Int)
    
    var baseURL: URL {
        return URL(string: "http://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .artistList:
            return "search"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch  self {
        case let .artistList(searchString, limit, offset):
            return .requestParameters(parameters: ["term":searchString,"entity":"musicArtist", "limit": limit, "offset": offset], encoding: URLEncoding())
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
}
