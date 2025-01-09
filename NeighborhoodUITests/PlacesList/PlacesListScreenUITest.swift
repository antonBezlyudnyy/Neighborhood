//
//  PlacesListScreenUITest.swift
//  NeighborhoodUITests
//
//  Created by Anton Bezlyudnyy on 10/11/24.
//

import XCTest

class PlacesListScreenUITest: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-places-success" : "1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testListHasCorrectNumberOfItems() {
        let list = app.otherElements.children(matching: .any)["placesList"]
        XCTAssertTrue(list.waitForExistence(timeout: 5), "The places list should be visible")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let listItems = list.otherElements.buttons.containing(predicate)
        XCTAssertEqual(listItems.count, 2, "There should be 2 items on the screen")
        
        XCTAssertTrue(listItems.staticTexts["Place1"].exists)
        XCTAssertTrue(listItems.staticTexts["1Street"].exists)
        XCTAssertTrue(listItems.staticTexts["200$"].exists)
        
        XCTAssertTrue(listItems.staticTexts["Place2"].exists)
        XCTAssertTrue(listItems.staticTexts["2Street"].exists)
        XCTAssertTrue(listItems.staticTexts["100$"].exists)
    }
}
