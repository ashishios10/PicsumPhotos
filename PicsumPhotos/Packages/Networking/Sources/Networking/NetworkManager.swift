//
//  NetworkManager.swift
//  
//
//  Created by Ashish Patel on 01/12/22.
//

import UIKit
import Utilities

/// MARK: - NetworkManager for bakend communication
public protocol NetWorkManagerProtocol {
    func request<T: Decodable>(request: Request,
                               parameters: Encodable?) async throws -> T
}

public struct NetWorkManager: NetWorkManagerProtocol {
    
    public init() {}
    
    private func checkNetworkConnection() throws {
        guard Reachability.isConnectedToNetwork() else {
            throw APIError.noInternet
        }
    }
    
    public func request<T: Decodable>(request: Request,
                                      parameters: Encodable?) async throws -> T {
        
        let session = URLSession(configuration: .default)
        
        try checkNetworkConnection()
        
        let (data, httpResponse) = try await session.data(for: request as URLRequest)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse,
              httpResponse.hasValidResponseCode() else {
            throw APIError.invalidResponse
        }
        do {
            return try CustomDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.invalidResponse
        }
    }
}
