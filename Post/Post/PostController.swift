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
        
        //let queryEndInterval = reset ? Date().timeIntervalSince1970 : posts.last?.queryTimestamp ?? Date().timeIntervalSince1970
        
        guard let baseURL = PostController.baseURL else { return }
        
        let getterPoint = baseURL.appendingPathComponent("json")
        
        var request = URLRequest(url: getterPoint)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            
            if let error = error {
                NSLog(error.localizedDescription)
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from fetch")
                completion()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let postsDictionary = try decoder.decode([String:Post].self, from: data)
                let posts: [Post] = postsDictionary.flatMap{ ($0.value) }
                let sortedPosts = posts.sorted(by: { $0.timestamp > $1.timestamp })
                
                if reset {
                    self.posts = sortedPosts
                } else {
                    self.posts.append(contentsOf: sortedPosts)
                }
                
                completion()
                
            } catch let error {
                NSLog("Error decoding: \(error.localizedDescription)")
                completion()
            }
        })
        dataTask.resume()
        
        
    }
    
}
