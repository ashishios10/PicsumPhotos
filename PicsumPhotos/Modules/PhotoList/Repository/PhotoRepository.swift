//
//  PhotoRepository.swift
//  PhotoItApp
//
//  Created by Ashish Patel on 1/21/23.
//

import UIKit
import Networking
import Models

/*
 ## PhotoRepository
 
 This class implements PhotoRepository methods.
 
 */

protocol PhotoRepository {
    func fetchPhotos(pageNo: Int) async throws -> [PhotoElement]
}

struct PhotoRepositoryImplementation: PhotoRepository {
    private var networkManger: NetWorkManagerProtocol!
    
    init(networkManger: NetWorkManagerProtocol) {
        self.networkManger = networkManger
    }
    
    /// Photo API Call using the "fetchPhotos" method, to retrieve list of Photo items.
    ///
    /// - Parameters:
    ///   - return: List of photos
    func fetchPhotos(pageNo: Int) async throws -> [PhotoElement] {
        guard let request = RequestConfig.fetchPhotos(pageNo: pageNo).value else { throw APIError.unknownError }
        return try await networkManger.request(request: request, parameters: nil)
    }
}
