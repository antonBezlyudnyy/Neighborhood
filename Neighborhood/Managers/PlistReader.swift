//
//  PlistReader.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 20.09.2024.
//

import Foundation

class PlistReader {

    /// Retreives plist options
    static func getPlistValue<T: Decodable>(by key: String, type: T.Type) -> T? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? T
    }
}
