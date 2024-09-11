//
//  Request.swift
//  
//
//  Created by Ashish Patel on 1/15/23.
//

import UIKit
import Utilities

public enum RequestConfig {
    case fetchPhotos(pageNo: Int)

    public var value: Request? {
        switch self {
        case .fetchPhotos(let pageNo):
            let urlString = String(format: APIURL.getPhotoList.getURL(),pageNo,  StoreLabConstants.perPage)
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}

enum RequestMethod: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
    var value: String {
        return self.rawValue
    }
}

/**
 ## Request
 
 This class provides URLRequest.
 
 */

final public class Request: NSMutableURLRequest {
    
    convenience init?(requestMethod: RequestMethod,
                      urlString: String,
                      bodyParams: [String: Any]? = nil) {
        guard let url =  URL.init(string: urlString) else {
            return nil
        }
        self.init(url: url)
        do {
            if let bodyParams = bodyParams {
                let data = try JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
                self.httpBody = data
            }
        } catch {}
        self.httpMethod = requestMethod.value
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
