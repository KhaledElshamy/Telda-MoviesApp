////
////  MoviesSearchViewUITests.swift
////  Telda-MoviesAppUITests
////
////  Created by Khaled Elshamy on 29/06/2025.
////
//
import XCTest
@testable import Telda_MoviesApp

class MoviesSceneUITests: XCTestCase {
    
    private var app:XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        app = nil
    }

    // NOTE: for UI tests to work the keyboard of simulator must be on.
    // Keyboard shortcut COMMAND + SHIFT + K while simulator has focus
    func testOpenMovieDetails_whenSearchBatmanAndTapOnFirstResultRow_thenMovieDetailsViewOpensWithTitleBatman() {
        
        // Search for Batman
        let searchText = "Batman Begins"
        app.searchFields["AccessibilityIdentifierSearchMovies"].tap()
        if !app.keys["A"].waitForExistence(timeout: 5) {
            XCTFail("The keyboard could not be found. Use keyboard shortcut COMMAND + SHIFT + K while simulator has focus on text input")
        }
        _ = app.searchFields["AccessibilityIdentifierSearchMovies"].waitForExistence(timeout: 10)
        app.searchFields["AccessibilityIdentifierSearchMovies"].typeText(searchText)
        app.buttons["search"].tap()
        
        // Tap on first result row
        app.tables.cells.staticTexts[searchText].tap()
        
        // Make sure movie details view
        XCTAssertTrue(app.otherElements["AccessibilityIdentifierMovieDetailsView"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.navigationBars[searchText].waitForExistence(timeout: 5))
    }
}
