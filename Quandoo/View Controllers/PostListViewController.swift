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
    var loadingView:UIView!
    var postsArray:[Post] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let username = self.username else {
            self.showError()
            return
        }
        
        self.title = "\(username)'s posts"
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x25ac72)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(downloadUsersPost), for: .valueChanged)
        self.tableView.refreshControl?.tintColor = UIColor(rgb: 0x25ac72)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 151
        self.tableView.separatorColor = .clear
        
        showLoadingView()
        downloadUsersPost()
    }
    
    // MARK: - Data MGMT
    @objc func downloadUsersPost() {
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
            self.hideLoadingView()
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
    
    func showLoadingView() {
        loadingView = UIView(frame: self.view.bounds)
        loadingView.backgroundColor = .black
        loadingView.alpha = 0.7
        
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        loadingIndicator.center = loadingView.center
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        loadingView.addSubview(loadingIndicator)
        
        self.view.addSubview(loadingView)
    }
    
    func hideLoadingView() {
        tableView.separatorColor = UIColor(rgb: 0x25ac72)
        self.tableView.refreshControl?.endRefreshing()
        self.loadingView.removeFromSuperview()
    }
}
