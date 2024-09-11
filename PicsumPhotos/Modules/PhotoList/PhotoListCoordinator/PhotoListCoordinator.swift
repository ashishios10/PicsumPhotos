//
//  PhotoListCoordinator.swift
//  PhotoItApp
//
//  Created by Ashish Patel on 1/21/23.
//

/*
 ## PhotoListCoordinator
 
 Provides navigation methods for PhotoList controller.
 
 */

import UIKit
import Utilities
import Models
import Networking

struct PhotoListCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let photoListViewModel = PhotoListViewModel(photoListCoordinator: self,
                                                    photoRepository: PhotoRepositoryImplementation(networkManger: NetWorkManager()))
        let photoListViewController = UIStoryboard(name: StoryboardName.main.rawValue,
                                                   bundle: .main).instantiateViewController(
                                                    identifier: PhotoListViewController.className,
                                                    creator: { coder -> PhotoListViewController? in
                                                        PhotoListViewController(coder: coder,
                                                                                viewModel: photoListViewModel)
                                                    })
        navigationController.setViewControllers([photoListViewController], animated: false)
    }
    
    func navigateToPhotoDetailScreen(responseViewModel: PhotoResponseViewModel) {
        let photoDetailCoordinator = PhotoDetailCoordinator(navigationController: navigationController,
                                                            responseViewModel: responseViewModel)
        let photoDetailViewController = photoDetailCoordinator.pushFlowToPhotoDetailViewController()
        navigationController.pushViewController(photoDetailViewController, animated: true)
    }
}
