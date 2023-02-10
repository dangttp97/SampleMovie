//
//  MoviesNetwork.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation

enum MovieEndpoint{
    case getNowPlayingMovies(offset: UInt)
    case getMovieDetails(id: Int)
}

extension MovieEndpoint: Endpoint{
    var baseURL: URL {
        return Environment.baseURL
    }
    
    var path: String {
        switch self{
        case .getNowPlayingMovies:
            return "/movie/now_playing"
        case .getMovieDetails(id: let id):
            return "/movie/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(Environment.apiKey)"]
    }
    
    var body: [String: Any]? {
        return nil
    }
    
    var urlParameters: [String : Any]? {
        switch self{
        case .getNowPlayingMovies(offset: let offset):
            return ["page": offset]
        case .getMovieDetails:
            return nil
        }
    }
}
