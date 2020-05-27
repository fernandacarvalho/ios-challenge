//
//  AppDelegate.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 25/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setInitialController()
        
        return true
    }
    
    func setInitialController() {
        window = UIWindow(frame: UIScreen.main.bounds)
               window?.rootViewController = StoryboardManager.packages.instantiateInitialViewController()
               window?.makeKeyAndVisible()
    }
}

