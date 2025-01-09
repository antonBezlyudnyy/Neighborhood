//
//  API.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 20.09.2024.
//

import Foundation

struct API {
    
    enum Endpoints {
        case places
        case placesImages(id: String)
        
        private var path: String {
            switch self {
            case .places:
                return "/data/places"
            case .placesImages(id: let id):
                return "/data/img/\(id)"
            }
        }
        
        var url: URL? {
            guard let baseURL = Configuration.PlistValues.baseUrl.value,
                  let url = URL(string: baseURL + self.path) else {
                return nil
            }
            
            return url
        }
    }
}
