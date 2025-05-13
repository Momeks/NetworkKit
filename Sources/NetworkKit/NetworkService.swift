//
//  NetworkService.swift
//  NetworkKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

/**
Protocol marked as Sendable to ensure all conforming types are safe to use across
concurrent contexts, required by Swift 6 for async functions.
 */
public protocol NetworkService: Sendable {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}
