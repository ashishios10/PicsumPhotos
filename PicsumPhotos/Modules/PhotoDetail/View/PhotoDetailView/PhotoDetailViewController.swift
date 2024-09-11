//
//  PhotoDetailViewController.swift
//  PhotoItApp
//
//  Created by Ashish Patel on 1/21/23.
//

/*
 ## PhotoDetailViewController
 
 Provides layout of Photo details screen.
 
 */

import UIKit
import Utilities
import Elements

final class PhotoDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: PrimaryLabel! {
        didSet {
            titleLabel.setDynamicCustomFont(type: .kFontOswaldRegular, size: .extraLargeFont)
        }
    }
    
    @IBOutlet weak var descriptionLabel: PrimaryLabel! {
        didSet {
            descriptionLabel.setDynamicCustomFont(type: .kFontRobotoRegular, size: .regularFont)
        }
    }
    
    // MARK: - Variables
    private let viewModel: PhotoResponseViewModel
    
    // MARK: - Initialization
    init?(coder: NSCoder, viewModel: PhotoResponseViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LfieCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        navigationItem.title = "photoList.details.title".localized()
        titleLabel.text = viewModel.author
        descriptionLabel.text = viewModel.url
        lazyLoadImageView()
    }
    
    func lazyLoadImageView() {
        let imageUrl = viewModel.imageUrlWithDownloadSize(width: "\(Int(photoImageView.frame.size.width))",
                                                          height: "\(Int(photoImageView.frame.size.height))")
        self.photoImageView.downloadImage(urlString: imageUrl, placeholderImageName: placeholderName)
    }
}
