//
//  PhotoElement.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

public struct PhotoElement: Codable {
    public let id: String
    public let author: String
    public let width: Int
    public let height: Int
    public let url: String
    public let downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
