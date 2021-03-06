//
//  PostListTableViewController.swift
//  Post
//
//  Created by Daniel Jin on 1/13/18.
//  Copyright © 2018 Daniel Jin. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var postController = PostController()

    
    // MARK: - IBActions
    
    @IBAction func refreshControlPulled(_ sender: UIRefreshControl) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        postController.fetchPosts {
            
            self.reloadTableView()
            
            DispatchQueue.main.async {
                sender.endRefreshing()
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        postController.fetchPosts {
            self.reloadTableView()
        }

    }
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
    
            // Turn off activity spinner?
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postController.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)

        let post = postController.posts[indexPath.row]
        
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(indexPath.row) - \(post.username) - \(Date(timeIntervalSince1970: post.timestamp))"
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
