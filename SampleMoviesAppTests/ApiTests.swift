//
//  MovieAPITests.swift
//  SampleMoviesAppTests
//
//  Created by Tran Thanh Phuong Dang on 04/02/2023.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import SampleMoviesApp

enum MockAPIEndpoint{
    case getMovies
}
extension MockAPIEndpoint: Endpoint{
    var baseURL: URL {
        return Environment.baseURL
    }
    
    var path: String {
        return "/movie/now_playing"
    }
    
    var method: SampleMoviesApp.HTTPMethod {
        return .GET
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(Environment.apiKey)"]
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var urlParameters: [String : Any]? {
        return ["page": 1]
    }
}

final class ApiTests: XCTestCase {
    func getAPIObservable() -> Observable<Paging<Movie>> {
        let provider = Provider<MockAPIEndpoint>()
        let observable: Observable<Paging<Movie>> = provider.perform(.getMovies)
        
        return observable
    }
    
    func testGetMoviesNotNil() throws {
        XCTAssertNotNil(try getAPIObservable().toBlocking().first())
    }
}
