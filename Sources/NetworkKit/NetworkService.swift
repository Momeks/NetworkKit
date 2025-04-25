//
//  NetworkService.swift
//  NetworkKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

public protocol NetworkService {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}
