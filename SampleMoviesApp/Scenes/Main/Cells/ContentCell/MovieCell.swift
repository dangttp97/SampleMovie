//
//  MovieCell.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 04/02/2023.
//

import UIKit

class MovieCell: UITableViewCell{
    @IBOutlet private weak var imgvBackground: UIImageView!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblPopularity: UILabel!
    
    func setupData(movie: Movie){
        imgvBackground.image(from: (movie.backgroundPath != nil ? Environment.imageBaseURL.appendingPathComponent("/w500" + movie.backgroundPath!) : URL(string: Strings.emptyImg.rawValue))!)
        lblName.text = movie.name
        lblPopularity.text = "\(movie.popularity)"
    }
}
