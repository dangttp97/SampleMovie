//
//  UIViewController+Extensions.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 03/02/2023.
//

import UIKit

extension UIViewController{
    class func instantiate<T: UIViewController>(with storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
