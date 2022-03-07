//
//  File.swift
//  
//
//  Created by MEKARI on 07/03/22.
//

import Foundation

public protocol HomeServiceable {
    func getTopRated() async throws -> Result<MovieResponse, RequestError>
    func getMovieDetail(with id: Int) async throws -> Result<MovieResults, RequestError>
}

public struct HomeServices: NetworkManager, HomeServiceable {
    
    public init() {}
    
    public func getTopRated() async throws -> Result<MovieResponse, RequestError> {
        return try await sendRequest(endpoint: HomeEndpoint.topRated, responseModel: MovieResponse.self)
    }
    
    public func getMovieDetail(with id: Int) async throws -> Result<MovieResults, RequestError> {
        return try await sendRequest(endpoint: HomeEndpoint.movieDetail(id: id), responseModel: MovieResults.self)
    }
    
}
