//
//  SearchProvider.swift
//  itunes-search
//
//  Created by Maksim on 12.05.2021.
//

import Moya

enum SearchProvider: TargetType {
    case artistList(searchString: String, limit: Int, offset: Int)
    case audioList(type: String, artistId: Int, limit: Int, offset: Int)
    
    var baseURL: URL {
        return URL(string: "http://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .artistList:
            return "search"
        case .audioList:
            return "lookup"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch  self {
        case let .artistList(searchString, limit, offset):
            return .requestParameters(parameters: ["term":searchString,
                                                   "entity":"musicArtist",
                                                   "limit": limit,
                                                   "offset": offset], encoding: URLEncoding())
        case .audioList(let type, let artistId, let limit, let offset):
            return .requestParameters(parameters: ["id":artistId,
                                      "entity":type,
                                      "limit": limit,
                                      "offset": offset], encoding: URLEncoding())
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
}
