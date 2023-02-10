//
//  Provider.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation
import RxSwift

class Provider<T: Endpoint>{
    func perform<ReturnType>(_ endpoint: T) -> Observable<ReturnType> where ReturnType: Decodable{
        return Observable<ReturnType>.create{ observable in
            var url = endpoint.baseURL.appendingPathComponent(endpoint.path)
            
            if let urlParams = endpoint.urlParameters{
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                
                components?.queryItems = urlParams.map{
                    return URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                
                url = components?.url == nil ? url : components!.url!
            }
            
            var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeInterval(15000))
            
            urlRequest.httpMethod = endpoint.method.rawValue
            urlRequest.allHTTPHeaderFields = endpoint.headers
            
            if let body = endpoint.body{
                do {
                    let bodyData = try JSONSerialization.data(withJSONObject: body, options: [])
                    urlRequest.httpBody = bodyData
                } catch {
                    observable.onError(error)
                }
            }
            
#if DEBUG
            NetworkLogger.log(request: urlRequest)
#endif
            
            let request = URLSession.shared.dataTask(with: urlRequest){ data, res, err in
#if DEBUG
                NetworkLogger.log(response: res as? HTTPURLResponse, data: data, error: err)
#endif
                
                guard let data = data,
                      let statusCode = (res as? HTTPURLResponse)?.statusCode,
                      (200...399).contains(statusCode),
                      err == nil
                else{
                    observable.onError(err!)
                    return
                }
                
                do{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let obj = try decoder.decode(ReturnType.self, from: data)
                    
                    observable.onNext(obj)
                    
                } catch {
                    observable.onError(error)
                }
                
                observable.onCompleted()
            }
            
            request.resume()
            
            return Disposables.create{
                request.cancel()
            }
        }
    }
}
