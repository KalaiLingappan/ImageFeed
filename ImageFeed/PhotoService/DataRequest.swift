//
//  DataRequest.swift
//  ImageFeed
//
//  Created by Kalaiprabha L on 11/07/22.
//

import Foundation

protocol DataRequest {
    associatedtype ResponseData: Decodable
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    var queryItems: [String : String] { get }
    
    func decode(_ data: Data) throws -> ResponseData
}

extension DataRequest {
    func decode(_ data: Data) throws -> ResponseData {
        let decoder = JSONDecoder()
        return try decoder.decode(ResponseData.self, from: data)
    }
}
