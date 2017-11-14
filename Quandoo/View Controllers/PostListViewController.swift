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

        downloadUsersPost()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data MGMT
    func downloadUsersPost() {
        guard let userId = self.userId else {
            return
        }
        downloadUsersPosts(userId: userId, completion: { posts in
            for post in posts {
                self.postsArray.append(Post(json: post))
            }
            
            self.tableView.reloadData()
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
            return cell
        }
        return UITableViewCell()
    }
}
