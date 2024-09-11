//
//  PhotoDetailCoordinator.swift
//  PhotoItApp
//
//  Created by Ashish Patel on 1/21/23.
//

/*
 ## PhotoDetailCoordinator
 
 Provides navigation methods for PhotoDetail controller.
 
 */

import UIKit
import Utilities
import Models

struct PhotoDetailCoordinator: Coordinator {
    private let navigationController: UINavigationController
    let responseViewModel: PhotoResponseViewModel
    
    init(navigationController: UINavigationController,
         responseViewModel: PhotoResponseViewModel) {
        self.navigationController = navigationController
        self.responseViewModel = responseViewModel
    }
    
    func pushFlowToPhotoDetailViewController() -> UIViewController {
        let photoDetailViewController = UIStoryboard(
            name: StoryboardName.main.rawValue,
            bundle: .main).instantiateViewController(identifier: PhotoDetailViewController.className,
                                                     creator: { coder -> PhotoDetailViewController? in
                PhotoDetailViewController(coder: coder, viewModel: self.responseViewModel)
            })
        return photoDetailViewController
    }
}
