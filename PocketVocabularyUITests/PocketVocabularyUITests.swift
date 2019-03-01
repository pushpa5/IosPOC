//
//  PocketVocabularyUITests.swift
//  PocketVocabularyUITests
//
//  Created by pushpa.n.bhat on 27/09/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import XCTest
@testable import PocketVocabulary
class PocketVocabularyUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
        func testTableview() {
            let app = XCUIApplication()
            let tablesQuery = app.tables
            app.tables.staticTexts["Synonyms"].tap()
            let nextbuttonButton = app.buttons["nextButton"]
            nextbuttonButton.tap()
            let previousbuttonButton = app.buttons["previousButton"]
            previousbuttonButton.tap()
            XCUIApplication().buttons["all"].tap()
            app.collectionViews.cells.otherElements.containing(.staticText, identifier: "10").element.tap()
            app.navigationBars["Synonyms"].buttons["back"].tap()
            tablesQuery.staticTexts["Practice test"].tap()
            app.alerts["alert"].buttons["No"].tap()
            app.tables.staticTexts["Practice test"].tap()
            app.alerts["alert"].buttons["Yes"].tap()
            app.buttons["nextButton"].tap()
            app.buttons["all"].tap()
            app.collectionViews.staticTexts["24"].tap()
            previousbuttonButton.tap()
            app.buttons["all"].tap()
            app.collectionViews.staticTexts["24"].tap()
            app.buttons["nextButton"].tap()
            app.buttons["finish"].tap()
            app.alerts["Alert"].buttons["No"].tap()
            app.buttons["finish"].tap()
            app.alerts["Alert"].buttons["Yes"].tap()
    }

}
