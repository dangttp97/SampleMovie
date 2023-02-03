//
//  NetworkError.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation

enum NetworkError: Error{
    case notFound
    case internalServerError
    case encodingFailed
    case unknown
}
