//
//  PhotoViewmodeTests.swift
//  ImageFeedTests
//
//  Created by Kalaiprabbha L on 15/02/22.
//

import XCTest
@testable import ImageFeed

class PhotoViewmodeTests: XCTestCase {
    var viewModel: ImageFeedViewModel?
    
    override func setUp() {
        super.setUp()
        viewModel =  ImageFeedViewModel(service: DataNetworkService())
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testFetchPhotosSuccess() {
        viewModel?.fetchPhotosForOffset(0, request: MockRequest())
        viewModel?.reloadViewClosure = {
            XCTAssertEqual(self.viewModel?.photos.count, 10)
        }
    }
    
    func testFetchPhotosErrorAlert() {
        viewModel?.fetchPhotosForOffset(0, request: MockRequestFailure())
        viewModel?.showAlertClosure = {
            do {
                let unwrappedValue = try XCTUnwrap(self.viewModel?.alertMessage)
                XCTAssertNotNil(unwrappedValue)
            } catch {
                
            }
        }
    }
}


struct MockRequest: DataRequest {
    var url: String { return "" }
    
    var method: HTTPMethod { .get }
    var headers: [String : String] { [:] }
    var queryItems: [String : String] { [:] }
    
    func decode(_ data: Data) throws -> [Photo] {
        guard let jsonData = HelperClass.readLocalFile(forName: "Mock") else {
            return []
        }
        
        do {
            let decodedJSON = try JSONDecoder().decode(ResponseData.self, from: jsonData)
            return decodedJSON
        } catch {
            return []
        }
    }
}

struct MockRequestFailure: DataRequest {
    var url: String { return "" }
    
    var method: HTTPMethod { .get }
    var headers: [String : String] { [:] }
    var queryItems: [String : String] { [:] }
    
    func decode(_ data: Data) throws -> [Photo] {
        throw NSError(domain: "", code: 101, userInfo: ["localizedDescription": "Error parsing JSON"])
    }
}

struct MockRequestURLFailure: DataRequest {
    typealias ResponseData = [Photo]
    
    var url: String { return "http://example.com:-80/" }
    var method: HTTPMethod { .get }
    var headers: [String : String] { [:] }
    var queryItems: [String : String] { [:] }
}



