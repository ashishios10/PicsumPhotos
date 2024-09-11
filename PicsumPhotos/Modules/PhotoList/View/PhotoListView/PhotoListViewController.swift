//
//  PhotoListViewController.swift
//  PhotoItApp
//
//  Created by Ashish Patel on 1/21/23.
//

/*
 ## PhotoListViewController
 
 Provides layout of Photo list.
 
 */

import UIKit
import Utilities
import Elements

final class PhotoListViewController: UIViewController {
    
    // MARK: - Variables
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = AppColor.secondaryColor.value
        collectionView.contentInset.top = contentPadding
        collectionView.contentInset.left = contentPadding
        collectionView.contentInset.right = contentPadding
        collectionView.register(PhotoViewCell.className)
        self.setSubviewToParent(collectionView)
        return collectionView
    }()
    
    private var viewModel: PhotoListViewModelProtocol
    private lazy var collectionAdaptor = CollectionViewAdapter(collectionView: collectionView, delegate: self)
    
    private var contentPadding = 8.0
    
    // MARK: - Initialization
    init?(coder: NSCoder, viewModel: PhotoListViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        navigationItem.title = applicationName
        setupBindings()
        fetchPhotos()
    }
    
    /// MARK: - Setup Bindings
    func setupBindings() {
        viewModel.reloadCollectionView = {
            self.reloadUI()
            ProgressHUD.removeSpinner()
        }
        viewModel.showError = {  errorMessage in
            ProgressHUD.removeSpinner()
            self.showAlert(message: errorMessage)
        }
    }
    
    /// MARK: - Setup Views
    @objc private func fetchPhotos() {
        ProgressHUD.showSpinner(onView: view,
                                "spinner.loading".localized())
        self.loadMorePhotos()
    }
    
    @objc private func reloadUI() {
        collectionAdaptor.setData(viewModel.arrayPhotoList)
    }
}

// MARK: - CollectionViewAdapterDelegate
extension PhotoListViewController: CollectionViewAdapterDelegate {
    func collecitonItemTapped(_ index: Int) {
        viewModel.didSelectPhoto(at: index)
    }
    
    internal func loadMorePhotos() {
        Task(priority: .userInitiated) {
            await viewModel.getPhotoList()
        }
    }
}
