//
//  APIURL.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

import Foundation

/// APIBaseURL
enum APIBaseURL: String {
    
    case baseURLLive = "https://picsum.photos/"
    
    static func getBaseURL() -> String {
        switch AppEnvironment.shared.environmentType {
        case .production:
            return APIBaseURL.baseURLLive.rawValue
        }
    }
}

public enum APIURL {
    case getPhotoList
    case imgeUrl(imageId: String, width: String, height: String)
    case none
    
    public func getURL() -> String {
        let baseURL = APIBaseURL.getBaseURL()
        switch self {
        case .getPhotoList:
            return baseURL + "v2/list?page=%d&limit=%d"
        case .imgeUrl(let imageId, let width, let height):
            return baseURL + "/id/\(imageId)/\(width)/\(height)"
        case .none:
            return ""
        }
    }
}
