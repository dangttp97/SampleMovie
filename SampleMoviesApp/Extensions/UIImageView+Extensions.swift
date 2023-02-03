//
//  UIImage+Extensions.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import UIKit

extension UIImageView{
    func image(from urlStr: String, onCompleteFetchingImage: ((_ imageData: Data?) -> Void)? = nil) {
        let url = URL(string: (urlStr))!
        let request = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, err in
            guard (err != nil) else {
                return
            }
            self.image = UIImage(data: data!)
            onCompleteFetchingImage?(data)
        })
        request.resume()
    }
}
