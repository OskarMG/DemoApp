//
//  NetworkService.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 14/5/25.
//

import Foundation

/// A shared service responsible for executing network requests
public struct NetworkService: @unchecked Sendable {

    /// The shared singleton instance of NetworkService.
    public static let shared = NetworkService()

    /// Private initializer to enforce singleton pattern.
    private init() {}

    public func request<T: Decodable>(
        _ endpoint: APIEndPoint,
        as type: T.Type
    ) async throws(NetworkServiceError) -> T {
        var urlRequest = endpoint.urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        #if DEBUG
        debugPrint("@APIEndPoint: ", urlRequest.url?.absoluteString ?? "NOT FOUND")
        #endif

        do {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 130
            let session = URLSession(configuration: config)
            let (data, response) = try await session.data(for: urlRequest)
            
            #if DEBUG
            debugPrint("----------------------")
            debugPrint("@Request URL: \(urlRequest.url?.absoluteString ?? "NOT FOUND")")
            debugPrint("----------------------\n")
            #endif

            guard let httpResponse = response as? HTTPURLResponse else {
                #if DEBUG
                debugPrint("❌ Invalid response received (no HTTPURLResponse)")
                #endif
                throw NetworkServiceError.unknown(URLError(.badServerResponse))
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                #if DEBUG
                debugPrint("❌ Backend error - status code: \(httpResponse.statusCode)")
                #endif
                throw NetworkServiceError.backendError(data, httpResponse.statusCode)
            }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            #if DEBUG
            debugPrint("❌ Decoding error: \(String(describing: decodingError))")
            #endif
            throw NetworkServiceError.decodingError(decodingError)
        } catch let networkError as NetworkServiceError {
            #if DEBUG
            debugPrint("❌ NetworkServiceError: \(String(describing: networkError))")
            #endif
            throw networkError
        } catch {
            #if DEBUG
            debugPrint("❌ Unknown error: \(String(describing: error))")
            #endif
            throw NetworkServiceError.unknown(error)
        }
    }
}
