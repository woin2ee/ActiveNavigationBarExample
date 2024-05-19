//
//  RandomDogResponse.swift
//  ActiveNavigationBarExample
//
//  Created by Jaewon Yun on 5/15/24.
//

import Foundation

struct RandomDogResponse: Decodable {
    
    /// A image url.
    let message: String
    
    /// Response status. "success" or "?"
    let status: String
}
