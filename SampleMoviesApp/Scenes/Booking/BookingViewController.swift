//
//  BookingScreen.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import UIKit
import WebKit

class BookingViewController: UIViewController{
    public var url: String?
    
    private var wbvBooking: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wbvBooking.frame = self.view.bounds
        let webUrl = URL(string: url ?? "https://google.com")
        let request = URLRequest(url: webUrl!)
        wbvBooking.load(request)
    }
}
