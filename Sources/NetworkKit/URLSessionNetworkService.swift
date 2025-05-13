//
//  URLSessionNetworkService.swift
//  NetworkKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

// Conforming to @unchecked Sendable because this class is immutable after initialization.
// Both URLSession and JSONDecoder are thread-safe for concurrent use when used as read-only.
// We use this class across concurrency boundaries (e.g., in async tasks or injected as dependencies),
// and need to assure the compiler it’s safe to do so, even though Swift cannot verify it automatically.

public final class URLSessionNetworkService: NetworkService, @unchecked Sendable {
    private var session: URLSession
    private var decoder: JSONDecoder
    
    public init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    public func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.urlRequest else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
            }
            
            return try decoder.decode(T.self, from: data)
            
        } catch let error as NetworkError {
            throw error
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingFailed(decodingError)
        } catch {
            throw NetworkError.connectionError(error)
        }
    }
}
