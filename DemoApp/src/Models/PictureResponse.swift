//
//  PictureResponse.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 14/5/25.
//

import Foundation

public typealias PictureResponse = [Picture]

public struct Picture: Codable, @unchecked Sendable {
    let id, author, url: String

    enum CodingKeys: String, CodingKey {
        case id, author
        case url = "download_url"
    }
}
