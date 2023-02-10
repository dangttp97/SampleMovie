//
//  ConfigurationViewModel.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 06/02/2023.
//

import Foundation
import RxSwift

class ConfigurationViewModel{
    private let service = ConfigurationService()
    private let disposeBag = DisposeBag()
    
    func getAllLanguages() {
        service.getAllLanguage().subscribe(onNext: { languages in
            GlobalTempVariables.languages = languages
        })
        .disposed(by: disposeBag)
    }
}
