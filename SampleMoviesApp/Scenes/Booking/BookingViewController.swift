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
    
    @IBOutlet private var wbvBooking: WKWebView!
    
    @objc private func handleClose(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wbvBooking.frame = self.view.bounds
        let webUrl = URL(string: url ?? "https://google.com")
        let request = URLRequest(url: webUrl!)
        wbvBooking.load(request)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = webUrl?.host
        
        if #available(iOS 13.0, *) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(handleClose(_:)))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}
