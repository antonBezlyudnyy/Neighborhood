//
//  NetworkManager.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 17.09.2024.
//

import Foundation

protocol NetworkManagerImpl {
    func makeRequest<T: Decodable>(session: URLSession,
                                   url: URL?,
                                   method: NetworkManager.HTTPMethod,
                                   body: [String: Any]?,
                                   headers: [String : String]?,
                                   responseType: T.Type) async throws -> T?
}

class NetworkManager: NetworkManagerImpl {
    
    /// Request types
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    /// Makes request with provided parameters and returns expected result with expected type `T`
    func makeRequest<T: Decodable>(session: URLSession = .shared,
                                   url: URL?,
                                   method: HTTPMethod = .GET,
                                   body: [String: Any]? = nil,
                                   headers: [String : String]? = nil,
                                   responseType: T.Type) async throws -> T? {
        // Define URL
        guard let url = url else {
            throw URLError(.badURL)
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Configure request with body
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        // Set headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Execute request using the session from the protocol
        let (data, response) = try await session.data(for: request)
        
        // Check the status code
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        // Handle case, when there is no response data
        guard !data.isEmpty else {
            return nil
        }
        
        // return simple data in case we do not need decoded object
        if responseType == Data.self {
            return data as? T
        }
        
        // Decode the JSON response data into the expected type
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}

