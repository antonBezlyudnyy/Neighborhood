//
//  PlacesListFailureUITests.swift
//  NeighborhoodUITests
//
//  Created by Anton Bezlyudnyy on 10/24/24.
//

import XCTest

final class PlacesListFailureUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override  func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-places-success" : "0"]
        app.launch()
    }
    
    override  func tearDown() {
        app = nil
    }
    
    func testAlertIsShownWhenPlacesLoadingFailed() {
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "There should be an alert on the screen")
        XCTAssertTrue(alert.staticTexts["Loading failed"].exists)
    }
}
