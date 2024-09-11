//
//  PhotoCellViewModel.swift
//  PhotoItApp
//
//  Created by Ashish Patel on 1/21/23.
//

/**
## PhotoViewProtocol

This class is usiful to display actual data.

*/

import Models
import Networking

protocol PhotoViewProtocol {
    var author: String {get}
    var url: String {get}
    func imageUrlWithDownloadSize(width: String, height: String) -> String
}

struct PhotoResponseViewModel: PhotoViewProtocol {
    
    /// MARK: - Variables
    var author: String
    var url: String

    private let imageURL: String
    private let imageID: String

    init(viewModel: PhotoElement) {
        self.imageURL = viewModel.downloadURL ?? ""
        self.imageID = viewModel.id
        self.author = viewModel.author
        self.url = viewModel.url
    }
    
    func imageUrlWithDownloadSize(width: String,
                              height: String) -> String {
        return APIURL.imgeUrl(imageId: self.imageID,
                              width: width,
                              height: height).getURL()
    }
}
