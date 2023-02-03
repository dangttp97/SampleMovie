//
//  Movie.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation

struct Movie{
    var id: Int
    var name: String
    var backgroundPath: String
    var popularity: Float
    var genres: [Genre]
    
    enum MovieKeys: String, CodingKey{
        case id = "id"
        case name = "title"
        case backgroundPath = "backdrop_path"
        case popularity
        case genres
    }
}

extension Movie: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKeys.self)
        
        popularity = try container.decode(Float.self, forKey: .popularity)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        backgroundPath = try container.decode(String.self, forKey: .backgroundPath)
        genres = try container.decode([Genre].self, forKey: .genres)
    }
}
