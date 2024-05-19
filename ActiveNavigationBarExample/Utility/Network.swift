//
//  Network.swift
//  ActiveNavigationBarExample
//
//  Created by Jaewon Yun on 5/15/24.
//

import Foundation

protocol Networking {
    associatedtype Response: Decodable
    func request(url: URL) async -> Response?
}

struct Network<Response: Decodable>: Networking {
    
    let urlSession: URLSession
    
    /// Default using `shared` instance of `URLSession`.
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    
    func request(url: URL) async -> Response? {
        guard let data = try? await urlSession.data(from: url).0 else {
            return nil
        }
        return try? JSONDecoder().decode(Response.self, from: data)
    }
}
