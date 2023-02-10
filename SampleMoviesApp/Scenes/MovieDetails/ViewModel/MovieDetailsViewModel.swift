//
//  MovieDetailsViewModel.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 04/02/2023.
//

import Foundation
import RxSwift

class MovieDetailsViewModel{
    let disposeBag = DisposeBag()
    let movieService = MovieService()
    var movieId: Int = 0
    var movieDetails = PublishSubject<MovieDetails>()
    var languages = PublishSubject<[Language]>()
    
    func getMovieDetails() {
        movieService.getMovieDetails(id: movieId).bind(to: movieDetails).disposed(by: disposeBag)
    }
}
