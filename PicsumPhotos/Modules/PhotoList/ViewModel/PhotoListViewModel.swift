//
//  PhotoListViewModel.swift
//  PhotoItApp
//
//  Created by Ashish Patel on 1/21/23.
//

/*
 ## PhotoListViewModel
 
 Helper class to spearate business logic from controller.
 
 */

import Models
import Utilities

protocol PhotoListViewModelProtocol {
    var reloadCollectionView: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var photoListCoordinator: PhotoListCoordinator? {get set}
    var arrayPhotoList: [PhotoElement] {get set}
    func didSelectPhoto(at index: Int)
    func getPhotoList() async
}

final class PhotoListViewModel: PhotoListViewModelProtocol {
    // MARK: - Properties
    var reloadCollectionView: (() -> Void)?
    var showError: ((String) -> Void)?
    var photoListCoordinator: PhotoListCoordinator?
    var arrayPhotoList = [PhotoElement]()
    private let photoRepository: PhotoRepository?
    private var totalPhotoItems = 0

    // MARK: - Methods
    init(photoListCoordinator: PhotoListCoordinator,
         photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
        self.photoListCoordinator = photoListCoordinator
    }
    
    func photoItem(at index: Int) -> PhotoElement {
        return arrayPhotoList[index]
    }
    
    func didSelectPhoto(at index: Int) {
        photoListCoordinator?.navigateToPhotoDetailScreen(responseViewModel: PhotoResponseViewModel(viewModel: arrayPhotoList[index]))
    }
    
    @MainActor
    func getPhotoList() async {
        do {
            let result = try await self.photoRepository?.fetchPhotos(pageNo: nextPageNo)
            self.arrayPhotoList.append(contentsOf: result ?? [])
            self.totalPhotoItems = self.arrayPhotoList.count
            self.reloadCollectionView?()
        } catch {
            self.showError?(error.localizedDescription)
        }
    }
    
    private var nextPageNo: Int {
        return (totalPhotoItems/StoreLabConstants.perPage)+1
    }
}
