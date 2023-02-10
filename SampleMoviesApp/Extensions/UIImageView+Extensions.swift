//
//  UIImageView+Extensions.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import UIKit

extension UIImageView{
    func image(from url: URL, onCompleteFetchingImage: ((_ imageData: Data?) -> Void)? = nil) {
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(Environment.apiKey)"]
        
        URLSession.shared.dataTask(with: urlRequest){ data, res, err in
            guard let httpURLResponse = res as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = res?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, err == nil,
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async{ [weak self] in
                guard let self = self else { return }
                
                self.image = image
            }
            onCompleteFetchingImage?(data)
        }.resume()
    }
}
