//
//  PlistReaderTests.swift
//  NeighborhoodTests
//
//  Created by Anton Bezlyudnyy on 30.09.2024.
//

import XCTest
@testable import Neighborhood

class PlistReaderTests: XCTestCase {
    
    func testPropertyExist() {
        // getting baseUrl value
        let result = PlistReader.getPlistValue(by: Configuration.PlistValues.baseUrl.path, type: String.self)
        XCTAssertNotNil(result, "Result shouldn't be nil")
    }
}
