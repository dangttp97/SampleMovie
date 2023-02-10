//
//  MovieDetails.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 03/02/2023.
//

import Foundation

struct MovieDetails{
    var backdropPath: String
    var genres: [Genre]
    var id: Int
    var originalLanguage, overview: String
    var popularity: Double
    var releaseDate: Date
    var runtime: Int
    var title: String
    
    fileprivate enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case releaseDate = "release_date"
        case runtime, id, title, overview, popularity, genres, adult
    }
}

extension MovieDetails: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        genres = try container.decode([Genre].self, forKey: .genres)
        id = try container.decode(Int.self, forKey: .id)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        releaseDate = try container.decode(Date.self, forKey: .releaseDate)
        runtime = try container.decode(Int.self, forKey: .runtime)
        title = try container.decode(String.self, forKey: .title)
    }
}
