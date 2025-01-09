//
//  DetailsImageResponseSuccessMock.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 10/29/24.
//

#if DEBUG

import Foundation
import SwiftUI

class DetailsImageResponseSuccessMock: NetworkManagerImpl {
    func makeRequest<T>(session: URLSession,
                        url: URL?,
                        method: NetworkManager.HTTPMethod,
                        body: [String : Any]?,
                        headers: [String : String]?,
                        responseType: T.Type) async throws -> T? where T : Decodable {
        return UIImage(systemName: "star.fill")?.pngData() as? T
    }
}
#endif
