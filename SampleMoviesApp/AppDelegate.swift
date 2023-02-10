//
//  AppDelegate.swift
//  SampleMoviesApp
//
//  Created by Tran Thanh Phuong Dang on 02/02/2023.
//

import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #unavailable(iOS 13.0){
            window = UIWindow(frame: UIScreen.main.bounds)
            
            let mainVC = MainViewController.instantiate(with: .main)
            
            window?.rootViewController = mainVC
            window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let mainVC = MainViewController.instantiate(with: .main)
        
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}

