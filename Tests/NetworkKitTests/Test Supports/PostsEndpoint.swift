//
//  PostsEndpoint.swift
//  NetworkKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation
import NetworkKit

public struct PostsEndpoint: Endpoint {
    
    public enum PostType : Sendable {
        case all
        case single(id: Int)
    }

    private let type: PostType

    public init(type: PostType) {
        self.type = type
    }

    public var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }

    public var path: String {
        switch type {
        case .all:
            return "posts"
        case .single(let id):
            return "posts/\(id)"
        }
    }

    public var method: HTTPMethod {
        .get
    }

    public var headers: [String: String]? {
        nil
    }

    public var queryItems: [URLQueryItem]? {
        return nil
    }

    public var body: Data? {
        nil
    }
}

// MARK: - Model
public struct Post: Codable, Equatable {
    public let userId: Int
    public let id: Int
    public let title: String
    public let body: String
}

