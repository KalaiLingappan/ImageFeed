//
//  ErrorHandler.swift
//  ImageFeed
//
//  Created by Kalaiprabha L on 11/07/22.
//

import Foundation

enum ErrorResponse: String, Error {
    case noNetwork = "No Network"
    case invalidEndpoint = "Invalid Endpoint"
    case invalidData = "Invalid Data"
    
    var errorCode: Int {
        404
    }
    
    var description: String {
        switch self {
        case .noNetwork: return "No internet connection"
        case .invalidData: return "Invalid Data"
        case .invalidEndpoint: return "Invalid URL"
        }
    }
    
    func getError() -> Error {
         NSError(
            domain: rawValue,
            code: errorCode,
            userInfo: ["description": description]
        )
    }
}

