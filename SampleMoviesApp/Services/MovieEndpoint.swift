//
//  MoviesNetwork.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation

enum MoviesAPIEnpoint{
    case getTrendingMovies(offset: UInt)
    case getMovieDetails(id: Int)
}

extension MoviesAPIEnpoint: Target{
    var body: Parameters? {
        return nil
    }
    
    var urlParameters: [String : Any]? {
        switch self{
        case .getTrendingMovies(offset: let offset):
            return ["page": offset]
        case .getMovieDetails(id: let id):
            return nil
        }
    }
    
    var encoding: Encoding? {
        return nil
    }
    
    var baseURL: URL {
        return Environment.baseURL
    }
    
    var path: String {
        switch self{
        case .getTrendingMovies(_):
            return "/movie/popular"
        case .getMovieDetails(id: let id):
            return "/movie/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var headers: [String : String]? {
        return ["Authorization": Environment.apiKey]
    }
}
