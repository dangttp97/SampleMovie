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
    var totalPages: Int

    private enum CodingKeys: String, CodingKey{
        case pageNumber = "page"
        case results = "results"
        case totalPages = "total_pages"
    }
}

extension Paging: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        pageNumber = try container.decode(UInt.self, forKey: .pageNumber)
        results = try container.decode([T].self, forKey: .results)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
    }
}

extension Paging: Equatable{
    static func == (lhs: Paging<T>, rhs: Paging<T>) -> Bool {
        return lhs.pageNumber == rhs.pageNumber && lhs.results.count == rhs.results.count && lhs.totalPages == rhs.totalPages
    }
}
