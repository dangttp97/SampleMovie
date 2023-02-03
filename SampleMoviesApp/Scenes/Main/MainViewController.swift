//
//  MainViewController.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

let cellName = "MovieTableViewCell"
let storyboardName = "MainViewController"

class MainViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private var viewModel = MainViewModel()
    
    @IBOutlet weak var tbvMovie: UITableView!
    
    func setupUI(){
        let cellNib = UINib(nibName: cellName, bundle: nil)
        tbvMovie.register(cellNib, forCellReuseIdentifier: cellName)
    }
    
    func setupData(){
        viewModel.getInitialMovies()
        viewModel.movies.bind(to: tbvMovie.rx.items(cellIdentifier: cellName, cellType: MovieTableViewCell.self)){ (index, data, cell) in
            cell.setupData(movie: data)
        }.disposed(by: disposeBag)
    }
    
    func setupRx(){
        tbvMovie.rx
            .modelSelected(Movie.self)
            .subscribe(onNext: { data in
                print("Selected item: \(data)")
            })
            .disposed(by: disposeBag)
        
        tbvMovie.rx.didScroll
            .subscribe{ [weak self] _ in
            guard let self = self else { return }
            
            let offSetY = self.tbvMovie.contentOffset.y
            let contentHeight = self.tbvMovie.contentSize.height
            
            if offSetY > (contentHeight - self.tbvMovie.frame.size.height - 100) {
                self.viewModel.fetchMoreMovies()
            }
        }
        .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRx()
        setupData()
    }
}
