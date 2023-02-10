//
//  ConfigurationEndpoint.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 06/02/2023.
//

import Foundation

enum ConfigurationEndpoint{
    case getAllLanguage
}

extension ConfigurationEndpoint: Endpoint{
    var baseURL: URL {
        return Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .getAllLanguage:
            return "/configuration/languages"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(Environment.apiKey)"]
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var urlParameters: [String : Any]? {
        return nil
    }
}
