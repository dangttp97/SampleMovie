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
    var backgroundPath: String?
    var popularity: Float
    var genreIds: [UInt]
    var releasedDate: Date
    
    fileprivate enum MovieKeys: String, CodingKey{
        case id = "id"
        case name = "title"
        case backgroundPath = "backdrop_path"
        case popularity
        case genreIds = "genre_ids"
        case releasedDate = "release_date"
    }
}

extension Movie: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKeys.self)
        
        popularity = try container.decode(Float.self, forKey: .popularity)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        backgroundPath = try? container.decode(String.self, forKey: .backgroundPath)
        genreIds = try container.decode([UInt].self, forKey: .genreIds)
        releasedDate = try container.decode(Date.self, forKey: .releasedDate)
    }
}
