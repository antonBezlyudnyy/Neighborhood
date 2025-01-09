//
//  PlacesResponseSuccessMock.swift
//  NeighborhoodTests
//
//  Created by Anton Bezlyudnyy on 10/8/24.
//

#if DEBUG

import Foundation

class PlacesResponseSuccessMock: NetworkManagerImpl {
    func makeRequest<T>(session: URLSession,
                        url: URL?,
                        method: Neighborhood.NetworkManager.HTTPMethod,
                        body: [String : Any]?, headers: [String : String]?,
                        responseType: T.Type) async throws -> T? where T : Decodable {
        
        if responseType == PlaceResult.self {
            return PlaceResult(places: [Place(id: "1",
                                              name: "Place1",
                                              address: "1Street",
                                              stars: 5, reviews: 100,
                                              price: "200$",
                                              description: "A lovely place",
                                              imageURL: nil),
                                        Place(id: "2",
                                              name: "Place2",
                                              address: "2Street",
                                              stars: 2, reviews: 70,
                                              price: "100$",
                                              description: "Bad place",
                                              imageURL: nil)]) as? T
        } else if responseType == ImageResult.self {
            return ImageResult(image: URL(string:"https://shorturl.at/VdSlR")!) as? T
        } else {
            return nil
        }
    }
}
#endif
