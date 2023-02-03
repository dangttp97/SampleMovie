//
//  MovieListViewModel.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation
import RxSwift

class MainViewModel{
    let service = MovieService()
    var movies: Observable<[Movie]> = Observable.of([])
    
    func getInitialMovies() -> Observable<[Movie]>{
        return service.getMovies(offset: 1)
    }
}
