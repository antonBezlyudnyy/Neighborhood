//
//  Configuration.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 17.09.2024.
//

import Foundation

struct Configuration {
    
    enum PlistValues {
        case baseUrl
        
        var path: String {
            switch self {
            case .baseUrl:
                return "baseUrl"
            }
        }
        
        var value: String? {
            return PlistReader.getPlistValue(by: self.path, type: String.self)
        }
    }
}


