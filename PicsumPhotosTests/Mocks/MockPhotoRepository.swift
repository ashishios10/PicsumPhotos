//
//  MockPhotoRepository.swift
//  PicsumPhotosTests
//
//  Created by Ashish Patel on 1/23/23.
//

import Foundation
import Models

@testable import PicsumPhotos

class MockPhotoRepository: NSObject {
    private var configureServiceClientCount = 0
    private var photos: [PhotoElement]?
    private var expectedError: Error?
    func expectFetch(photos: [PhotoElement]?,
                     error: Error?) {
        self.photos = photos
        self.expectedError = error
        self.configureServiceClientCount += 1
    }
    func resetCounts() {
        configureServiceClientCount = 0
    }
    func verify() -> Bool {
        return configureServiceClientCount == 0
    }
}

extension MockPhotoRepository: PhotoRepository {
    func fetchPhotos(pageNo: Int) async throws -> [PhotoElement] {
        configureServiceClientCount-=1
        if let error = self.expectedError {
            throw error
        } else {
            return TestDataGenerator.getDummyPhotoModelContract()!
        }
    }
}
