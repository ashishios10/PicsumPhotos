//
//  CollectionViewAdapter.swift
//  PicsumPhotos
//
//  Created by Ashish Patel on 1/23/23.
//

/**
 ## CollectionViewAdapter
 
 This class provides the reusable component feature.
 Implemented Adapter desing pattern
 
 */

import UIKit
import Utilities
import Models

protocol CollectionViewAdapterDelegate {
    func collecitonItemTapped(_ index: Int)
    func loadMorePhotos()
}

final class CollectionViewAdapter: NSObject {
    private let collectionView: UICollectionView
    private var delegate: CollectionViewAdapterDelegate?
    
    var items = [PhotoElement]()
    
    init(collectionView: UICollectionView,
         delegate: CollectionViewAdapterDelegate?) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setData(_ data:[PhotoElement]) {
        self.items = data
        reloadData()
    }
    
    private func reloadData() {
        collectionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = UIScreen.main.bounds.height
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        if endScrolling >= scrollView.contentSize.height - offset {
            delegate?.loadMorePhotos()
        }
    }
}

/// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension CollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collecitonItemTapped(indexPath.row)
    }
}

extension CollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.className, for: indexPath) as! PhotoViewCell
        cell.viewModel = PhotoResponseViewModel(viewModel: self.items[indexPath.row])
        return cell
    }
}

extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding: CGFloat = 16.0
        let cellWidth = (UIWindow.isLandscape ? (collectionView.frame.size.width / 5.0) : (collectionView.frame.size.width / StoreLabConstants.photoColumnCount)) - cellPadding
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
