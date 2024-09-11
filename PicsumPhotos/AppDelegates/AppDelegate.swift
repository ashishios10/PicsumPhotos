//
//  AppDelegate.swift
//  PicsumPhotos
//
//  Created by Ashish Patel on 1/22/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UIDevice.current.isDeviceJailbroken {
           // exit(0)
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            return false
        }
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        return true
    }
}

