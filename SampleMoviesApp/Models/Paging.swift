//
//  Pagination.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 03/02/2023.
//

import Foundation

struct Paging<T: Decodable>{
    var pageNumber : UInt
    var results: [T]

    enum CodingKeys: String, CodingKey{
        case pageNumber = "page"
        case results
    }
}

extension Paging: EmptyModel{
    private init(){
        pageNumber = 0
        results = []
    }
    
    static func emptyValue() -> Paging<T> {
        return Paging<T>()
    }
}

extension Paging: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        try pageNumber = container.decode(UInt.self, forKey: .pageNumber)
        try results = container.decode([T].self, forKey: .results)
    }
}
