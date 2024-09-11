//
//  CustomDecoder.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

import Foundation

/// Custom decoder for json parsing
public final class CustomDecoder: JSONDecoder {
    public override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        do {
            return try super.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
