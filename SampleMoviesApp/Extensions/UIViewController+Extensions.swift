//
//  UIViewController+Extensions.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 03/02/2023.
//

import UIKit

extension UIViewController{
    class func instantiate<T>(storyboardName: String? = nil, viewControllerId: String? = nil) -> T where T: UIViewController{
        let storyboard = UIStoryboard(name: storyboardName ?? String(describing: T.self), bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId ?? String(describing: T.self))
        return viewController as! T
    }
}
