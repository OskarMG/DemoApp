//
//  CreateContactEndPoint.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 14/5/25.
//

import Foundation

public enum CreateContactEndPoint: APIEndPoint {
    
    case getPictureCollection(page: Int, limit: Int)

    public var method: HTTPMethod { return .get }
    public var headers: [String : String]? { return nil }
    public var baseURL: URL { URL(string: "https://picsum.photos/v2/")! }
    
    public var parameters: [String : Any]? {
        switch self {
        case .getPictureCollection(let page, let limit):
            return [
                "page": "\(page)",
                "limit": "\(limit)",
            ]
        }
    }
    
    public var path: String {
        switch self {
        case .getPictureCollection:
            return "list"
        }
    }
}
