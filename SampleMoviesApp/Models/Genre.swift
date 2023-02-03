//
//  Genre.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation

struct Genre{
    var id: Int
    var name: String
    
    enum GenreKeys: String, CodingKey{
        case id
        case name
    }
}

extension Genre: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
