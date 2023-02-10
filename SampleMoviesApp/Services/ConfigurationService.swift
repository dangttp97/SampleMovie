//
//  ConfigurationService.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 06/02/2023.
//

import Foundation
import RxSwift

class ConfigurationService{
    private let provider = Provider<ConfigurationEndpoint>()
    
    func getAllLanguage() -> Observable<[Language]>{
        return provider.perform(.getAllLanguage)
    }
}
