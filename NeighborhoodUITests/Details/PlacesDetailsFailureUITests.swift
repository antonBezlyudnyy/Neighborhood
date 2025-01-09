//
//  PlacesDetailsFailureUITests.swift
//  NeighborhoodUITests
//
//  Created by Anton Bezlyudnyy on 10/28/24.
//

import XCTest

final class PlacesDetailsFailureUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-places-success" : "1",
                                 "-details-success" : "0"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testImageLoadingFailedWhenItemIsTapped() {
        let list = app.otherElements.children(matching: .any)["placesList"]
        XCTAssertTrue(list.waitForExistence(timeout: 5), "The places list should not be visible")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let listItems = list.otherElements.buttons.containing(predicate)
        XCTAssertEqual(listItems.count, 2, "There should not be items on the screen")
        listItems.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["Place1"].exists)
        XCTAssertTrue(app.staticTexts["1Street"].exists)
        XCTAssertTrue(app.staticTexts["200$"].exists)
        XCTAssertTrue(app.staticTexts["A lovely place"].exists)
        
        let image = app.otherElements.children(matching: .any)["placeDetailsImage"]
        XCTAssertFalse(image.waitForExistence(timeout: 2), "The image should not be visible")
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists, "There should be an alert on the screen")
        XCTAssertTrue(alert.staticTexts["Image loading failed"].exists)
    }
}
