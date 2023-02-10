//
//  ExtensionTests.swift
//  SampleMoviesAppTests
//
//  Created by Tran Thanh Phuong Dang on 06/02/2023.
//

import UIKit
import XCTest
@testable import SampleMoviesApp

class MockViewController: UIViewController{
    
}

final class ExtensionTests: XCTestCase{
    func testGetCorrectTypeViewController() throws {
        let mainVC = MainViewController.instantiate(with: .main)
        
        return XCTAssertEqual(String(describing: mainVC), "MainViewController")
    }
}
