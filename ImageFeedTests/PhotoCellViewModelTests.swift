//
//  PhotoCellViewModelTests.swift
//  ImageFeedTests
//
//  Created by Kalaiprabha L on 23/06/22.
//

import XCTest
@testable import ImageFeed

class PhotoCellViewModelTests: XCTestCase {
    var cellViewModel: PhotoCellViewModel?
    
    override func setUpWithError() throws {
        cellViewModel = PhotoCellViewModel(Photo(id: "testID", author: ""))
    }

    override func tearDownWithError() throws {
        cellViewModel = nil
    }

    func testPhotoUrl() {
        do {
            let unwrappedValue = try XCTUnwrap(cellViewModel?.url)
            XCTAssertEqual(unwrappedValue,URL(string: "https://picsum.photos/id/testID/150/200"))
        } catch {
            
        }
    }
}
