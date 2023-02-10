//
//  Language.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 06/02/2023.
//

import Foundation

struct Language{
    var isoName: String
    var englishName: String
    
    private enum CodingKeys: String, CodingKey{
        case isoName = "iso_639_1"
        case englishName = "english_name"
    }
}

extension Language: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        isoName = try container.decode(String.self, forKey: .isoName)
        englishName = try container.decode(String.self, forKey: .englishName)
    }
}
