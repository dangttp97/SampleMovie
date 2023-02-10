//
//  MovieListViewModel.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import Foundation
import RxCocoa
import RxSwift

class NowPlayingViewModel{
    private let disposeBag = DisposeBag()
    private let service = MovieService()
    private var offset: UInt = 1
    private var totalPages = 1
    
    var movies = BehaviorRelay<[Movie]>(value: [])
    let refreshControlCompleted = PublishSubject<Bool>()
    let fetchMoreDataCompleted = PublishSubject<Bool>()
    
    func getInitialMovies(){
        service.getNowPlayingMovies(offset: offset)
            .map{
                self.totalPages = $0.totalPages
                return $0.results.sorted(by: { return $0.releasedDate < $1.releasedDate })
            }
            .bind(to: movies)
            .disposed(by: disposeBag)
    }
    
    func refreshing(){
        offset = 1
        totalPages = 1
        self.refreshControlCompleted.onNext(false)
        service.getNowPlayingMovies(offset: offset)
            .map{
                self.totalPages = $0.totalPages
                return $0.results.sorted(by: { return $0.releasedDate < $1.releasedDate })
            }
            .subscribe(onNext: { movies in
                self.refreshControlCompleted.onNext(true)
                self.movies.accept(movies)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchMoreMovies(){
        if(offset <= totalPages){
            offset += 1
            service.getNowPlayingMovies(offset: offset)
                .withLatestFrom(movies, resultSelector: {return ($0, $1)})
                .map { (new, old) -> [Movie] in
                    let newMovies = new.results.sorted(by: { return $0.releasedDate < $1.releasedDate })
                    return (old + newMovies)
                }
                .subscribe(onNext: { movies in
                    self.movies.accept(movies)
                    self.fetchMoreDataCompleted.onNext(true)
                })
                .disposed(by: disposeBag)
        } else {
            return
        }
    }
}
