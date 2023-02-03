//
//  MovieTableViewCell.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import UIKit
import RxSwift

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var imgvBackground: UIImageView!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblPopularity: UILabel!
    
    func setupData(movie: Movie){
        imgvBackground.image(from: "\(Environment.baseURL)\(movie.backgroundPath)")
        lblName.text = movie.name
        lblPopularity.text = "\(movie.popularity)"
    }

}
