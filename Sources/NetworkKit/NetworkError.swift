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
        case .invalidURL:
            return "Invalid request. Please try again later."
        case .requestFailed:
            return "Failed to connect to the server. Please try again later."
        case .decodingFailed:
            return "We’re having trouble processing data. Please try again."
        case .invalidResponse:
            return "Unexpected response from the server."
        case .connectionError:
            return "Please check your internet connection."
        case .unauthorized:
            return "You need to log in again to continue."
        }
    }
}
