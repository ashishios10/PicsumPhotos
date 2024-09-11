//
//  File.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

import Foundation

/// MARK: - API ResponseHandler

public extension HTTPURLResponse {
    func hasValidResponseCode() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
