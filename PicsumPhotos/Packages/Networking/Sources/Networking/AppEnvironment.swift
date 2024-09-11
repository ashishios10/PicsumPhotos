//
//  File.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

/// AppEnvironment
enum Environment {
    case production
}

final class AppEnvironment {
    
    static let shared = AppEnvironment()
    var environmentType: Environment = .production
}
