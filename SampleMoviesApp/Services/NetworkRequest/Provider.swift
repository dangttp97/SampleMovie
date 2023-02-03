//
//  Provider.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation
import Alamofire
import RxSwift

class Provider<T: Target>{
    func perform<ReturnType>(_ target: T) -> Observable<ReturnType> where ReturnType: Decodable{
        Observable<ReturnType>.create{ observable in
            var dataRequest: DataRequest
            
            print(target)
            
            if let headers = target.headers,
               let urlParameters = target.urlParameters{
                dataRequest = AF.request(target.baseURL.appendingPathExtension(target.path),
                                         method: Alamofire.HTTPMethod(rawValue: target.method.rawValue),
                                         parameters: urlParameters,
                                         encoding: URLEncoding.default,
                                         headers: HTTPHeaders(headers))
            } else{
                dataRequest = AF.request(target.baseURL.appendingPathExtension(target.path),
                                         method: Alamofire.HTTPMethod(rawValue: target.method.rawValue))
            }
            
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
