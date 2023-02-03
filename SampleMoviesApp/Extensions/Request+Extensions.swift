//
//  Request+Extensions.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 03/02/2023.
//

import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
#if DEBUG
        debugPrint("=======================================")
        debugPrint(self)
        debugPrint("=======================================")
#endif
        return self
    }
}
