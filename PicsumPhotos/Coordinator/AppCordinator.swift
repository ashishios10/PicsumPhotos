//
//  AppCordinator.swift
//  PhotiItApp
//
//  Created by Ashish Patel on 1/21/23.
//

/*
## Coordinator

This protocol provides method for app starting.

*/

import UIKit
import Utilities

protocol Coordinator {
    func start()
}

extension Coordinator { func start() {} }

struct AppCoordinator: Coordinator {
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        navigationController.setupDefaultApperance()
        let photoListCoordinator = PhotoListCoordinator(navigationController: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        photoListCoordinator.start()
    }
}
