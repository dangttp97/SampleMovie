//
//  Environment.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation

public enum Environment {
    fileprivate static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let baseURL: URL = {
        guard let baseURLStr = Environment.infoDictionary["BASE_URL"] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        guard let url = URL(string: baseURLStr) else {
            fatalError("Base URL is invalid")
        }
        return url
    }()
    
    static let imageBaseURL: URL = {
        guard let imageBaseURLStr = Environment.infoDictionary["IMAGE_BASE_URL"] as? String else {
            fatalError("Image base URL not set in plist for this environment")
        }
        guard let url = URL(string: imageBaseURLStr) else {
            fatalError("Image base URL is invalid")
        }
        return url
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary["API_KEY"] as? String else {
            fatalError("API key not set in plist for this environment")
        }
        
        return apiKey
    }()
}
