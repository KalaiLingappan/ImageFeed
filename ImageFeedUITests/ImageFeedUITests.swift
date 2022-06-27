//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Kalaiprabbha L on 12/02/22.
//

import XCTest

class ImageFeedUITests: XCTestCase {

    override func setUpWithError() throws {
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
    }

    func testCollection() {
        let app = XCUIApplication()
        app.launch()
        
        let elementQuery = app.collectionViews.element.children(matching: .cell)
        XCTAssertTrue(elementQuery.count > 0)
        XCTAssertTrue(elementQuery.staticTexts.firstMatch.label == "Alejandro Escamilla")
        XCTAssertTrue(elementQuery.images["image"].exists)
    }
}

