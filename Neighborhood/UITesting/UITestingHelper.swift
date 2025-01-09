//
//  UITestingHelper.swift
//  Neighborhood
//
//  Created by Anton Bezlyudnyy on 10/24/24.
//


#if DEBUG

import Foundation

struct UITestingHelper {
    
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
    static var isPlacesSuccessful: Bool {
        ProcessInfo.processInfo.environment["-places-success"] == "1"
    }
    
    static var isDetailsSuccessful: Bool {
        ProcessInfo.processInfo.environment["-details-success"] == "1"
    }
}

#endif
