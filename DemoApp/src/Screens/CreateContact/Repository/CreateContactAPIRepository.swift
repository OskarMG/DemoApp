//
//  CreateContactAPIRepository.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 14/5/25.
//

import Foundation

protocol CreateContactAPIRepositoring {
    func getPictureCollection() async throws(NetworkServiceError) -> PictureResponse
}

public final class CreateContactAPIRepository: CreateContactAPIRepositoring {
    
    /// Shared instance used to perform API requests.
    private var networkService = NetworkService.shared

    // MARK: - Initialization

    public init() {}
    
    private func debugError(_ error: NetworkServiceError) {
        #if DEBUG
        switch error {
        case let .invalidStatusCode(val):
            debugPrint("invalidStatusCode :", val)
        case let .decodingError(error):
            debugPrint("decodingError:", error)
        case let .backendError(data, val):
            debugPrint("backendError:", data, val)
        case let .unknown(error):
            debugPrint("unknown error:", error.localizedDescription)
        }
        #endif
    }
    
    func getPictureCollection() async throws(NetworkServiceError) -> PictureResponse {
        do throws(NetworkServiceError) {
            let endPoint = CreateContactEndPoint.getPictureCollection(page: 1, limit: 100)
            let response = try await networkService.request(
                endPoint,
                as: PictureResponse.self
            )
            return response
        } catch {
            debugError(error)
            throw error
        }
    }
}
