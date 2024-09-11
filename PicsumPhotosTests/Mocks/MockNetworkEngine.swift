//
//  MockNetworkEngine.swift
//  PicsumPhotosTests
//
//  Created by Ashish Patel on 1/23/23.
//

import Foundation
import Networking
import Utilities

class MockNetworkEngine: NSObject {
    private var configureServiceClientCount = 0
    private var expectedData: Data?
    private var expectedError: NSError?
    func expectPerformRequest(data: Data?,
                              error: NSError?) {
        self.expectedData = data
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

extension MockNetworkEngine: NetWorkManagerProtocol {
    func request<T>(request: Request, parameters: Encodable?) async throws -> T where T : Decodable {
        configureServiceClientCount-=1
        if let error = self.expectedError {
            throw error
        } else {
            return try CustomDecoder().decode(T.self, from: expectedData!)
        }
    }
}
