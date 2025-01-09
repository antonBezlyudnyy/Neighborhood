//
//  PlacesResponseFailureMock.swift
//  NeighborhoodTests
//
//  Created by Anton Bezlyudnyy on 10/8/24.
//

#if DEBUG

import Foundation

class PlacesResponseFailureMock: NetworkManagerImpl {
    func makeRequest<T>(session: URLSession,
                        url: URL?,
                        method: Neighborhood.NetworkManager.HTTPMethod,
                        body: [String : Any]?, headers: [String : String]?,
                        responseType: T.Type) async throws -> T? where T : Decodable {
        
        throw URLError(.badURL)
    }
}
#endif
