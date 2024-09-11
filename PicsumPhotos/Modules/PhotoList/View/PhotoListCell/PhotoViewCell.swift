//
//  PhotoViewCell.swift
//  PhotoItApp
//
//  Created by Ashish Patel on 1/21/23.
//

/*
 ## PhotoViewCell
 
 Provides layout of custom cell of Photo.
 
 */

import UIKit
import Utilities

class PhotoViewCell: UICollectionViewCell {
    
    /// MARK: - IBOutlets
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    /// MARK: - Variables
    
    var viewModel: PhotoViewProtocol? {
        didSet {
            updateContent()
        }
    }
    
    /// MARK: - View Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    /// MARK: - Configure Views
    
    func updateContent() {
        if let imageUrl = viewModel?.imageUrlWithDownloadSize(width: "\(Int(frame.size.width))",
                                                              height: "\(Int(frame.size.height))") {
            self.thumbnailImageView.downloadImage(urlString: imageUrl, placeholderImageName: placeholderName)
        }
    }
}

