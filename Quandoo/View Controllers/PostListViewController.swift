//
//  PostListViewController.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class PostListViewController: UITableViewController {
    
    var username: String?
    var userId: Int?
    
    var postsArray:[Post] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let username = self.username else {
            self.title = "An error Occured"
            return
        }
        
        self.title = "\(username)'s posts"
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x25ac72)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 151
        
        downloadUsersPost()
    }
    
    // MARK: - Data MGMT
    func downloadUsersPost() {
        guard let userId = self.userId else {
            return
        }
        
        Requests.shared().downloadUsersPosts(userId: userId, completion: { posts, error in
            if let posts = posts {
                for post in posts {
                    do {
                        try self.postsArray.append(Post(json: post))
                    } catch {
                        print("An error occured while downloading posts")
                        self.showError()
                    }
                }
                
                self.tableView.reloadData()
            } else {
                print(error!)
            }
        })
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as? PostCell {
            let post = postsArray[indexPath.row]
            
            cell.config(title: post.title, body: post.body)
            
            cell.layoutIfNeeded()
            
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Errors
    func showError() {
        let alertController = UIAlertController(title: "Error", message: "An error occured while downloading posts", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
