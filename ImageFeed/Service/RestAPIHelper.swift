//
//  RestAPIHelper.swift
//  ImageFeed
//
//  Created by Kalaiprabbha L on 13/02/22.
//

import Reachability

protocol NetworkService {
    func fetchDataFor<Request: DataRequest>(request: Request, completionHandler: @escaping ((Result<Request.ResponseData,Error>) -> Void))
}

struct DataNetworkService: NetworkService {
    private func getURLComponent<Request: DataRequest>(request: Request) -> URLComponents? {
        URLComponents(string: request.url)
    }
    
    private func getQueryItems(queryItemsURL: [String : String]) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItemsURL.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            queryItems.append(urlQueryItem)
        }
        return queryItems
    }
    
    func getURLRequest<Request: DataRequest>(request: Request) -> URLRequest? {
        guard var urlComponent = getURLComponent(request: request) else {
            return nil
        }
        
        urlComponent.queryItems = getQueryItems(queryItemsURL: request.queryItems)
        
        guard let url = urlComponent.url else {
           return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        return urlRequest
    }
    
    func isReachable() -> Bool {
        Reachability(hostName: AppURLs.baseURL).isReachable()
    }
    
    func fetchDataFor<Request: DataRequest>(request: Request, completionHandler: @escaping ((Result<Request.ResponseData,Error>) -> Void)) {
        guard isReachable() else {
            return completionHandler(.failure(ErrorResponse.noNetwork.getError()))
        }
        
        guard let urlRequest = getURLRequest(request: request) else {
            return completionHandler(.failure(ErrorResponse.invalidEndpoint.getError()))
        }
       
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completionHandler(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode,let data = data {
                do {
                    try completionHandler(.success(request.decode(data)))
                } catch let error as NSError {
                    completionHandler(.failure(error))
                }
                return
            }
            
            return completionHandler(.failure(NSError()))
        }
        .resume()
    }
}
