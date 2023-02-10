//
//  Helpers.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 06/02/2023.
//

import Foundation

class Helpers{
    class func convertToHoursString(with minutes: Int) -> String{
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        return (hours > 1 ? "\(hours) hours" : "\(hours) hour") + ", \(remainingMinutes) minutes"
    }
}
