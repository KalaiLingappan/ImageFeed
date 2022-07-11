//
//  Constants.swift
//  ImageFeed
//
//  Created by Kalaiprabha L on 11/07/22.
//

import Foundation

struct AppURLs {
    static let baseURL = "https://picsum.photos/"
}

enum HTTPMethod: String {
    case get = "GET"
}

enum URLEndPoint: String {
    case list = "/v2/list"
    case detailImage = "/150/200"
}
