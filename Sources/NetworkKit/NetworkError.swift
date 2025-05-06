//
//  NetworkError.swift
//  NetworkKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingFailed(Error)
    case invalidResponse
    case connectionError(Error)
    case unauthorized
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .decodingFailed(let decodingError):
            return "Failed to decode the response: \(decodingError)"
        case .invalidResponse:
            return "Invalid response received from the server"
        case .connectionError(let error):
            return "Connection error: \(error.localizedDescription)"
        case .unauthorized:
            return "Authentication required"
        }
    }
}

public extension NetworkError {
    var userMessage: String {
        switch self {
        case .invalidURL, .requestFailed, .decodingFailed, .invalidResponse:
            return "Something went wrong. Please try again."
        case .connectionError:
            return "Please check your internet connection."
        case .unauthorized:
            return "You need to log in again to continue."
        }
    }
}
