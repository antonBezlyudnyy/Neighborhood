//
//  PlaceListViewModel.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 10/8/24.
//

import Foundation

final class PlaceListViewModel: ObservableObject {
    
    private let networkManager: NetworkManagerImpl!
    @Published var places: [Place] = []
    
    init(networkManager: NetworkManagerImpl = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Fetches and returns a list of `Place`s with their `imageURL` property set.
    func loadPlaces() async throws {
        // TODO: Implement this function. See the README for more details.
        // Create manager instance.
        // call the method andd feed him all the params
        do {
            let placesResult = try await networkManager.makeRequest(session: .shared,
                                                                    url: API.Endpoints.places.url,
                                                                    method: .GET,
                                                                    body: nil,
                                                                    headers: nil,
                                                                    responseType: PlaceResult.self)
            guard let placesResult = placesResult, !placesResult.places.isEmpty else {
                return
            }
            
            await MainActor.run {
                places.removeAll()
                places = placesResult.places
            }
        } catch {
            throw error
        }
    }
    
    func loadPlacesImageURLs() async throws {
        guard !places.isEmpty else {
            return
        }
        // For each loaded place load it's url data
        for i in 0..<places.count {
            let id = places[i].id
            let imageResult = try await networkManager.makeRequest(session: .shared,
                                                                   url: API.Endpoints.placesImages(id: id).url,
                                                                   method: .GET,
                                                                   body: nil,
                                                                   headers: nil,
                                                                   responseType: ImageResult.self)
            await MainActor.run {
                places[i].imageURL = imageResult?.image
            }
        }
    }
}
