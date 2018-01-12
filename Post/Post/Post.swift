//
//  Post.swift
//  Post
//
//  Created by Daniel Jin on 1/12/18.
//  Copyright © 2018 Daniel Jin. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    init(username: String, text: String, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        
        self.username = username
        self.text = text
        self.timestamp = timestamp
        
    }
    
    // MARK: - Properties
    let username: String
    let text: String
    let timestamp: TimeInterval
    
}
