//
//  MovieListViewModel.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation
import RxSwift

class MainViewModel{
    private let service = MovieService()
    private var offset: UInt = 1
    var movies: Observable<[Movie]> = Observable.of([])
    
    
    func getInitialMovies(){
        movies = service.getMovies(offset: offset).map{ return $0.results }
    }
    
    func fetchMoreMovies(){
        offset += 1
        _ = movies.concat(service.getMovies(offset: offset).map{ return $0.results })
    }
}
