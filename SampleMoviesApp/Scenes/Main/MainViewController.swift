//
//  MainViewController.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

let cellName = "MovieCell"

class MainViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private var nowPlayingVM = NowPlayingViewModel()
    private var configVM = ConfigurationViewModel()
    
    @IBOutlet weak var tbvMovie: UITableView!
    
    private lazy var viewSpinner: UIView = {
         let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
         let spinner = UIActivityIndicatorView()
         spinner.center = view.center
         view.addSubview(spinner)
         spinner.startAnimating()
         return view
     }()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    func setupUI(){
        self.navigationController?.title = "Now Playing"
        let cellNib = UINib(nibName: cellName, bundle: nil)
        
        tbvMovie.register(cellNib, forCellReuseIdentifier: cellName)
        tbvMovie.refreshControl = refreshControl
    }
    
    func setupData(){
        nowPlayingVM.getInitialMovies()
        configVM.getAllLanguages()
    }
    
    func setupRx(){
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.nowPlayingVM.refreshing()
            })
            .disposed(by: disposeBag)
        
        nowPlayingVM.movies.bind(to: tbvMovie.rx.items(cellIdentifier: cellName, cellType: MovieCell.self)){ index, data, cell in
            cell.setupData(movie: data)
        }
        .disposed(by: disposeBag)
        
        nowPlayingVM.refreshControlCompleted.subscribe(onNext: { _ in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        })
        .disposed(by: disposeBag)
        
//        nowPlayingVM.fetchMoreDataCompleted.bind(onNext: { completed in
//            if(completed){
//                DispatchQueue.main.async {
//                    self.tbvMovie.rx.
//                }
//            }
//        }).disposed(by: disposeBag)
        
        //Table view
        tbvMovie.rx.setDelegate(self).disposed(by: disposeBag)
        tbvMovie.rx
            .modelSelected(Movie.self)
            .subscribe(onNext: { data in
                let movieDetailsVC: MovieDetailsViewController = MovieDetailsViewController.instantiate(with: .movieDetails)
                movieDetailsVC.movieId = data.id
                self.navigationController?.pushViewController(movieDetailsVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        tbvMovie.rx.didScroll
            .subscribe{ [weak self] _ in
                guard let self = self else { return }
                
                let offSetY = self.tbvMovie.contentOffset.y
                let contentHeight = self.tbvMovie.contentSize.height
                
                if offSetY > (contentHeight - self.tbvMovie.frame.size.height - 500) {
                    self.nowPlayingVM.fetchMoreMovies()
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

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
