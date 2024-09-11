//
//  PhotoRepositoryTests.swift
//  PicsumPhotosTests
//
//  Created by Ashish Patel on 1/23/23.
//

import XCTest
import Networking
import Models
@testable import PicsumPhotos

class PhotoRepositoryTests: XCTestCase {
    
    private var photoRepositoryUnderTest: PhotoRepository!
    private let mockNetworkEngine = MockNetworkEngine()
    
    override func setUp() {
        super.setUp()
        photoRepositoryUnderTest = PhotoRepositoryImplementation(networkManger: mockNetworkEngine)
    }
    
    override func tearDown() {
        XCTAssertTrue(mockNetworkEngine.verify())
        mockNetworkEngine.resetCounts()
    }
    
    func testsFetchPhotosWhichReturnsInvalidResponse() async {
        let expectedErrorMessage = "Unable to find records"
        let expectedError = TestDataGenerator.getGenerateError(messsage: expectedErrorMessage)
        mockNetworkEngine.expectPerformRequest(data: nil, error: expectedError)
        do {
            _ = try await photoRepositoryUnderTest.fetchPhotos(pageNo: 1)
            XCTFail()
        } catch {
            XCTAssertEqual(expectedError?.localizedDescription, error.localizedDescription)
        }
    }
    
    func testsfetchPhotosWhichReturnsValidResponse() async {
        var photos: [PhotoElement] = []
        mockNetworkEngine.expectPerformRequest(data: TestDataGenerator.getMockData(), error: nil)
        do {
            photos = try await photoRepositoryUnderTest.fetchPhotos(pageNo: 1)
            XCTAssertTrue(photos.count > 0)
        } catch {
            XCTFail()
        }
    }
}
