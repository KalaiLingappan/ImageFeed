//
//  ImageFeedViewModel.swift
//  ImageFeed
//
//  Created by Kalaiprabbha L on 15/02/22.
//

import UIKit

class ImageFeedViewModel {
    private var service: NetworkService
    init(service: NetworkService) {
        self.service = service
    }
    var photos: [Photo] = [Photo]() {
        didSet {
            reloadViewClosure?()
        }
    }
    var alertMessage: String? {
        didSet {
            showAlertClosure?()
        }
    }
    
    var reloadViewClosure: (()->())?
    var showAlertClosure: (()->())?
    
    private var request = PhotoDataRequest(endPoint: URLEndPoint.list)
    
    func fetchPhotosForOffset(_ offset: Int) {
        request.setOffest(offset)
        service.fetchDataFor(request: request) { [weak self] result in
            switch result {
            case .success(let data):
                self?.photos += data
            case .failure(let error):
                self?.alertMessage = error.localizedDescription
            }
        }
    }
}
