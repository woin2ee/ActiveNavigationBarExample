//
//  ImageLoader.swift
//  ActiveNavigationBarExample
//
//  Created by Jaewon Yun on 5/15/24.
//

import UIKit

protocol ImageLoading {
    func load(from url: URL) async -> UIImage?
}

struct ImageLoader: ImageLoading {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func load(from url: URL) async -> UIImage? {
        let imageData = try? await urlSession.data(from: url).0
        guard let imageData = imageData else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
//    func load(from url: URL) -> Data {
//        
//    }
}
