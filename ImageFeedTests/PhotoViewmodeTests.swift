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
        viewModel =  ImageFeedViewModel(service: MockService())
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testFetchPhotos() {
        viewModel?.fetchPhotosForOffset(0)
        viewModel?.reloadViewClosure = { [weak self] in
            XCTAssertEqual(self?.viewModel?.photos.count, 10)
        }
    }
}



class MockService: NetworkService {
    func fetchDataFor<Request: DataRequest>(request: Request, completionHandler: @escaping ((Result<Request.ResponseData, Error>) -> Void)) {
        do {
            try completionHandler(.success(request.decode(Data())))
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }
    
    func simulateFailure() {
        //simulate failure and check
    }
}

struct MockRequest: DataRequest {
    var url: String { return "" }
    
    var method: HTTPMethod { .get }
    var headers: [String : String] { [:] }
    var queryItems: [String : String] { [:] }
    
    func decode(_ data: Data) throws -> [Photo] {
        let path = Bundle.main.path(forResource: "Mock", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let photos = try! decoder.decode(ResponseData.self, from: data)
        return photos
    }
}



