//
//  MockNetworkService.swift
//  NetworkKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

/*** Marked @unchecked Sendable to satisfy Swift 6's protocol conformance requirement
 while manually ensuring thread safety across concurrent access */
public final class MockNetworkService: NetworkService, @unchecked Sendable {
    public var mockData: Any?
    public var shouldThrowError: Bool = false
    public var errorToThrow: NetworkError = .invalidResponse

    public init() {}

    public func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        if shouldThrowError {
            throw errorToThrow
        }

        guard let result = mockData as? T else {
            throw NetworkError.decodingFailed(NSError(domain: "Mock decoding failed", code: -1))
        }

        return result
    }
}
