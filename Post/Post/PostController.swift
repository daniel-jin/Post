//
//  PostController.swift
//  Post
//
//  Created by Daniel Jin on 1/12/18.
//  Copyright © 2018 Daniel Jin. All rights reserved.
//

import Foundation

class PostController {
    
    // MARK: - Properties
    
    static let baseURL = URL(string: "https://dm-post.firebaseio.com/posts")

    var posts: [Post] = []
    
    func fetchPosts(reset: Bool = true, completion: @escaping() -> Void) {
        
        guard let baseURL = PostController.baseURL else { return }
        
        let getterPoint = baseURL.appendingPathComponent("json")
        
        var request = URLRequest(url: getterPoint)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog(error.localizedDescription)
                completion()
                return
            }
            
            
            
        }
        
        
        
    }
    
}
