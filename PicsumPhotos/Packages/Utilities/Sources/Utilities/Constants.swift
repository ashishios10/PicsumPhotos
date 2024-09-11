//
//  Constants.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

import UIKit

public let applicationName = "appName.Photo".localized()
public let placeholderName = "placeholder"

public struct StoreLabConstants {
    public static let perPage = 25
    public static let photoColumnCount: CGFloat = 2.0
}

public enum StoryboardName: String {
    case main = "Main"
}

/// Error messages with localized
public enum ErrorMessage: String {
    case noInternet
    case invalidResponse
    case couldNotFind
    case unknownError
    
    public var localizedText: String {
        switch self {
        case .noInternet:
            return "app.noInternet.error".localized()
        case .invalidResponse:
            return "app.invalidResponse.error".localized()
        case .couldNotFind:
            return "app.couldNotFind.error".localized()
        case .unknownError:
            return "app.unknownError.error".localized()
        }
    }
}

/// Font size
public enum AppFontSize: CGFloat {
    case extraLargeFont = 24
    case regularFont = 20
}

public enum fontType: String {
    case kFontOswaldBold = "Oswald-Bold"
    case kFontOswaldRegular = "Oswald-Regular"
    case kFontRobotoRegular = "Roboto-Regular"
}

/// Font size
public enum AppColor {
    case primaryColor
    case secondaryColor
}

public extension AppColor {
    var value: UIColor {
        get {
            switch self {
            case .primaryColor:
                return UIColor(named: "Primary") ?? .darkGray
            case .secondaryColor:
                return UIColor(named: "Secondary") ?? .white
            }
        }
    }
}
