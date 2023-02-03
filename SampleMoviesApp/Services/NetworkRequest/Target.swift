//
//  Target.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation
import Alamofire

typealias Parameters = Alamofire.Parameters
typealias Encoding = Alamofire.ParameterEncoding

protocol Target{
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Parameters? { get }
    var urlParameters: [String: Any]? { get }
    var encoding: Encoding? { get }
}
