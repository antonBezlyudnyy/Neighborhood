//
//  PlacesDetailsSuccessUITests.swift
//  NeighborhoodUITests
//
//  Created by Anton Bezlyudnyy on 10/28/24.
//

import XCTest

final class PlacesDetailsSuccessUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-places-success" : "1",
                                 "-details-success" : "1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testUserInfoIsCorrectWhenItemIsTappedScreenLoads() {
        let list = app.otherElements.children(matching: .any)["placesList"]
        XCTAssertTrue(list.waitForExistence(timeout: 5), "The places list should be visible")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let listItems = list.otherElements.buttons.containing(predicate)
        XCTAssertEqual(listItems.count, 2, "There should be 2 items on the screen")
        listItems.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["Place1"].exists)
        XCTAssertTrue(app.staticTexts["1Street"].exists)
        XCTAssertTrue(app.staticTexts["200$"].exists)
        XCTAssertTrue(app.staticTexts["A lovely place"].exists)
        
        let image = app.otherElements.children(matching: .any)["placeDetailsImage"]
        XCTAssertTrue(image.waitForExistence(timeout: 2), "The image should be visible")
    }
}
