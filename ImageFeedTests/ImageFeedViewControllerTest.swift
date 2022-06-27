//
//  ImageFeedViewControllerTest.swift
//  ImageFeedTests
//
//  Created by Kalaiprabha L on 26/06/22.
//

import XCTest
@testable import ImageFeed

class ImageFeedViewControllerTest: XCTestCase {
    var viewController: ImageFeedViewController?
    
    override func setUpWithError() throws {
        viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? ImageFeedViewController
        let _ = viewController?.view
        viewController?.viewModel.photos = getJSON()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func getJSON() -> [Photo] {
        guard let jsonData = HelperClass.readLocalFile(forName: "Mock") else {
            return []
        }
        
        do {
            let decodedJSON = try JSONDecoder().decode([Photo].self, from: jsonData)
            return decodedJSON
        } catch {
            return []
        }
    }
    
    func testSetView() {
        viewController?.collectionView.reloadData()
        if let collectionView = viewController?.collectionView, let cell = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0))  as? PhotoCollectionViewCell, let photo = viewController?.viewModel.photos.first {
            cell.setImageFor(photo)
            XCTAssertEqual(cell.author.text, "Alejandro Escamilla")
        }
    }
}
