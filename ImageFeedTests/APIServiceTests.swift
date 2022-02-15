//
//  APIServiceTests.swift
//  ImageFeedTests
//
//  Created by Kalaiprabbha L on 15/02/22.
//

import XCTest
@testable import ImageFeed

class APIServiceTests: XCTestCase {
    var mockService: NetworkService?
    
    override func setUp() {
        super.setUp()
        mockService = MockService()
    }

    override func tearDown() {
        super.tearDown()
        mockService = nil
    }
    
    func testData() {
        mockService?.fetchDataFor(request: MockRequest(), completionHandler: { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 10)
            case .failure:
               break
            }
        })
    }

}

