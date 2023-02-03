//
//  MovieDetailsService.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation
import RxSwift

class MovieService{
    let provider = Provider<MovieEndpoint>()
    
    func getMovies(offset: UInt) -> Observable<Paging<Movie>> {
        return provider.perform(.getTrendingMovies(offset: offset))
    }
    
    func getMovieDetails(id: Int) -> Observable<Movie> {
        return self.provider.perform(.getMovieDetails(id: id))
    }
}
