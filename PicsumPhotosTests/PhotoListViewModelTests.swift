//
//  PhotoListViewModelTests.swift
//  PicsumPhotosTests
//
//  Created by Ashish Patel on 1/23/23.
//

import XCTest
@testable import PicsumPhotos

class PhotoListViewModelTests: XCTestCase {
    private var viewModelUnderTest: PhotoListViewModel!
    private let mockPhotoRepository = MockPhotoRepository()
    
    override func setUp() {
        super.setUp()
        viewModelUnderTest = PhotoListViewModel(photoListCoordinator: PhotoListCoordinator(navigationController: UINavigationController()), photoRepository: mockPhotoRepository)
    }
    
    override func tearDown() {
        XCTAssertTrue(mockPhotoRepository.verify())
        mockPhotoRepository.resetCounts()
    }
    
    func testGetPhotosWhichReturnTheValidResponse() async {
        self.mockPhotoRepository.expectFetch(photos: TestDataGenerator.getDummyPhotoModelContract(), error: nil)
        await self.viewModelUnderTest?.getPhotoList()
        XCTAssertTrue(self.viewModelUnderTest.arrayPhotoList.count > 0)
    }
    
    func testGetPhotosWhichThrowsError() async {
        let expectedErrorMessage = "Unable to find records"
        let exptedError = TestDataGenerator.getGenerateError(messsage: expectedErrorMessage)
        self.mockPhotoRepository.expectFetch(photos: nil, error: exptedError)
        await self.viewModelUnderTest?.getPhotoList()
        XCTAssertTrue(self.viewModelUnderTest.arrayPhotoList.count == 0)
    }
}
