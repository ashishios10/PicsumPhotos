//
//  APIError.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

import Foundation
import Utilities

/// MARK: - APIError for error handling
public enum APIError: Error {
    case noInternet
    case invalidResponse
    case couldNotFind
    case unknownError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return ErrorMessage.noInternet.localizedText
        case .invalidResponse:
            return ErrorMessage.invalidResponse.localizedText
        case .couldNotFind:
            return ErrorMessage.couldNotFind.localizedText
        case .unknownError:
            return ErrorMessage.unknownError.localizedText
        }
    }
}
