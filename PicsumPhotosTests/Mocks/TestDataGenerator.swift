//
//  TestDataGenerator.swift
//  PicsumPhotosTests
//
//  Created by Ashish Patel on 1/23/23.
//

import Foundation
import Models

final class TestDataGenerator: NSObject {
    static func getGenerateError(messsage: String) -> NSError? {
        return NSError(domain: "com.example.error",
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey: messsage])
    }

    static func getDummyPhotoModelContract() -> [PhotoElement]? {
        let decoder = JSONDecoder()
        let response = try? decoder.decode([PhotoElement].self, from: getMockData()!)
        return response
    }
    // Convert from JSON to nsdata
    static func getMockData() -> Data? {
        let json = "[{\n\t\t\t\"id\": \"0\",\n\t\t\t\"author\":\"Alejandro Escamilla\",\n\t\t\t\"width\":5000,\n\t\t\t\"height\":5000,\n\t\t\t\"url\": \"https://unsplash.com/photos/yC-Yzbqy7PY\",\n\t\t\t\"id\": \"https://picsum.photos/id/0/5000/3333\" \n\t}]"
        return Data(json.utf8)
    }
}
