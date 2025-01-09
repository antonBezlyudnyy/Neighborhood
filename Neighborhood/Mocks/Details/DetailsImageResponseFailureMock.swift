//
//  DetailsImageResponseFailureMock.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 10/29/24.
//

#if DEBUG

import Foundation

class DetailsImageResponseFailureMock: NetworkManagerImpl {
    func makeRequest<T>(session: URLSession,
                        url: URL?,
                        method: NetworkManager.HTTPMethod,
                        body: [String : Any]?,
                        headers: [String : String]?,
                        responseType: T.Type) async throws -> T? where T : Decodable {
        throw URLError(.badURL)
    }
}
#endif
