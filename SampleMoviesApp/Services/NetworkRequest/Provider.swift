//
//  Provider.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation
import Alamofire
import RxSwift

typealias EmptyModel = EmptyResponse

class Provider<T: Target>{
    func perform<ReturnType>(_ target: T) -> Observable<ReturnType> where ReturnType: Decodable{
        return Observable<ReturnType>.create{ observable in
            let url = target.baseURL.appendingPathExtension(target.path)
            let dataRequest = AF.request(url,
                                         method: Alamofire.HTTPMethod(rawValue: target.method.rawValue),
                                         parameters: target.urlParameters,
                                         encoding: target.encoding ?? URLEncoding.default,
                                         headers: target.headers == nil ? nil : HTTPHeaders(target.headers!)).debugLog()
            dataRequest.responseDecodable(of: ReturnType.self){ response in
                guard let returnValue = response.value, response.error == nil
                else {
                    observable.onError(response.error ?? NetworkError.unknown)
                    return
                }
                
                observable.onNext(returnValue)
                observable.onCompleted()
            }
            
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
}
