import Foundation

/// Old implementation replaced with PlaceListViewModel
struct PlaceFetcher {
    
    /// Fetches and returns a list of `Place`s with their `imageURL` property set.
    static func loadPlacesWithImages() async throws -> [Place] {
        
        // TODO: Implement this function. See the README for more details.
        // Create manager instance.
        let networkManager = NetworkManager()
       
        // call the method andd feed him all the params
        let placesResult = try await networkManager.makeRequest(url: API.Endpoints.places.url,
                                                                responseType: PlaceResult.self)
        guard let placesResult = placesResult, !placesResult.places.isEmpty else {
            return []
        }
        
        var places = placesResult.places
        
        // For each loaded place load it's url data
        for i in 0..<places.count {
            let id = places[i].id
            let imageResult = try await networkManager.makeRequest(url: API.Endpoints.placesImages(id: id).url,
                                                                   responseType: ImageResult.self)
            places[i].imageURL = imageResult?.image
        }
        
        return places
    }
}
