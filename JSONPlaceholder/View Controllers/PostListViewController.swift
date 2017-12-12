//
//  PostListViewController.swift
//  JSONPlaceholder
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController, PostDataModelDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var username: String?
    var userId: Int?
    
    private var dataSource = PostDataModel()
    internal var postsArray = [Post](){
        didSet {
            tableView?.reloadData()
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let username = username else {
            showError()
            return
        }
        
        title = "\(username)'s posts"
        setupTableView()
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoadingView()
        downloadUsersPost()
    }
    
    func setupTableView() {
        tableView.refreshControl = RefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(downloadUsersPost), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 151
        tableView.separatorColor = .clear
    }
    
    // MARK: - DataModel
    @objc func downloadUsersPost() {
        guard let userId = userId else {
            showError()
            return
        }
        dataSource.requestData(url: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)")
    }
    
    // MARK: - PostDataModelDelegate
    func didReceiveDataUpdate(posts: [Post]) {
        postsArray = posts
        hideLoadingView(tableView: tableView)
    }
    
    func didFailDataUpdateWithError(error: Error) {
        hideLoadingView(tableView: tableView)
        showError()
    }
}

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as? PostCell {
            cell.config(post: postsArray[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        }
        return UITableViewCell()
    }
}

extension PostListViewController: UITableViewDelegate {}
