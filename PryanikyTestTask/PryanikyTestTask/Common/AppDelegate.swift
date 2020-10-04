//
//  AppDelegate.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 30.09.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = TestViewController()
        let _ = TestPresenter(view: viewController, network: NetworkManager())
        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

