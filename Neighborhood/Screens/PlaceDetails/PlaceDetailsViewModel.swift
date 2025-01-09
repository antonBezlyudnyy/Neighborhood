//
//  PlaceDetailsViewModel.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 10/29/24.
//

import Foundation

final class PlaceDetailsViewModel: ObservableObject {
    
    private let networkManager: NetworkManagerImpl!
    
    init(networkManager: NetworkManagerImpl = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadImage(url: URL?) async throws -> Data? {
        do {
            let data = try await networkManager.makeRequest(session: .shared,
                                                            url: url,
                                                            method: .GET,
                                                            body: nil,
                                                            headers: nil,
                                                            responseType: Data.self)
            return data
        } catch {
            throw error
        }
    }
}
