//
//  HelperClassTests.swift
//  ImageFeedTests
//
//  Created by Kalaiprabha L on 26/06/22.
//

import XCTest
@testable import ImageFeed

class HelperClassTests: XCTestCase {
    func testReadFile() {
        XCTAssertNil(HelperClass.readLocalFile(forName: "failure"))
    }
}

