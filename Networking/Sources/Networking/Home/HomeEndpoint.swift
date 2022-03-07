//
//  File.swift
//  
//
//  Created by MEKARI on 07/03/22.
//

import Foundation

public enum HomeEndpoint {
    case topRated
    case movieDetail(id: Int)
}

extension HomeEndpoint: Endpoint {
    public var path: String {
        switch self {
        case .topRated:
            return "movie/top_rated?api_key=45e5d6363dec05a53f59bcc6af7e551f&language=en-US&page=1"
        case .movieDetail(let id):
            return "movie/\(id)?api_key=45e5d6363dec05a53f59bcc6af7e551f&language=en-US"
        }
    }
    
    public var method: RequestMethod {
        switch self {
        case .topRated, .movieDetail:
            return .get
        }
    }
    
    public var header: [String: String]? {
        nil
    }
    
    public var body: [String: String]? {
        switch self {
        case .topRated, .movieDetail:
            return nil
        }
    }
    
}
