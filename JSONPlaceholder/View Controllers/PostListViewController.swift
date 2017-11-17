//
//  PostListViewController.swift
//  JSONPlaceholder
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class PostListViewController: UITableViewController, PostDataModelDelegate {
    
    var username: String?
    var userId: Int?
    
    fileprivate var postsArray = [Post](){
        didSet {
            tableView?.reloadData()
        }
    }
    private var dataSource = PostDataModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let username = self.username else {
            self.showError()
            return
        }
        
        title = "\(username)'s posts"
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x25ac72)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(downloadUsersPost), for: .valueChanged)
        refreshControl?.tintColor = UIColor(rgb: 0x25ac72)
        refreshControl?.backgroundColor = .white
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 151
        tableView.separatorColor = .clear
        
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoadingView()
        downloadUsersPost()
    }
    
    // MARK: - PostDataModelDelegate
    func didReceiveDataUpdate(posts: [Post]) {
        postsArray = posts
        tableView.reloadData()
        hideLoadingView()
    }
    
    func didFailDataUpdateWithError(error: Error) {
        hideLoadingView()
        showError()
    }
    
    // MARK: - DataModel
    @objc func downloadUsersPost() {
        guard let userId = self.userId else {
            self.showError()
            return
        }
        
        dataSource.requestData(url: "https://jsonplaceholder.typicode.com/posts?userId=", userId: userId)
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as? PostCell {
            cell.config(post: postsArray[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        }
        return UITableViewCell()
    }
}
