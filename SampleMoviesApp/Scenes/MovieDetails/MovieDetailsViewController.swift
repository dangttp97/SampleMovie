//
//  MovieDetailsViewController.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewController: UIViewController {
    let disposeBag = DisposeBag()
    var movieId: Int = 0
    private let viewModel = MovieDetailsViewModel()
    
    @IBOutlet private weak var btnNavigate: UIButton!
    @IBOutlet private weak var imgvBackdrop: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblLang: UILabel!
    @IBOutlet private weak var lblDuration: UILabel!
    @IBOutlet private weak var lblGenres: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var btnBooking: UIButton!
    
    private func setupData(){
        viewModel.movieId = self.movieId
        viewModel.getMovieDetails()
    }
    
    private func setupUI(){
        viewModel.movieDetails
            .subscribe(onNext: { movieDetails in
                DispatchQueue.main.async {
                    self.imgvBackdrop.image(from: Environment.imageBaseURL.appendingPathComponent("/w500" + movieDetails.backdropPath))
                    self.lblTitle.rx.text.onNext(movieDetails.title)
                    self.lblLang.rx.text.onNext("Language: \(GlobalTempVariables.languages.first(where: {$0.isoName == movieDetails.originalLanguage})?.englishName ?? "No language")")
                    self.lblDuration.rx.text.onNext("Duration: \(Helpers.convertToHoursString(with: movieDetails.runtime))")
                    self.lblGenres.text = movieDetails.genres.map{ return $0.name }.joined(separator: ", ")
                    self.lblOverview.text = movieDetails.overview
                }
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction private func handleBookingTapped() {
        let bookingVC: BookingViewController = BookingViewController.instantiate(with: .booking)
        bookingVC.url = "https://www.gv.com.sg/"
        navigationController?.pushViewController(bookingVC, animated: true)
    }
    
    @IBAction private func handleBackTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
}
