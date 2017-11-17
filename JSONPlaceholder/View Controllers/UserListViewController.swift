//
//  UserListViewController.swift
//  JSONPlaceholder
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController, UserDataModelDelegate {

    fileprivate var usersArray = [User](){
        didSet {
            tableView?.reloadData()
        }
    }
    private let dataSource = UserDataModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x25ac72)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(downloadUsers), for: .valueChanged)
        refreshControl?.tintColor = UIColor(rgb: 0x25ac72)
        refreshControl?.backgroundColor = .white
        
        tableView.separatorColor = .clear
        
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLoadingView()
        downloadUsers()
    }

    // MARK: - Data MGMT
    @objc private func downloadUsers() {
        dataSource.requestData(url: "https://jsonplaceholder.typicode.com/users")
    }
    
    // MARK: - UserDataModelDelegate
    func didReceiveDataUpdate(users: [User]) {
        usersArray = users
        hideLoadingView()
    }
    
    func didFailDataUpdateWithError(error: Error) {
        hideLoadingView()
        showError()
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as? UserCell {
            cell.config(user: usersArray[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PostListViewController") as? PostListViewController {
            
            vc.username = usersArray[indexPath.row].username
            vc.userId = usersArray[indexPath.row].id
            
            navigationController?.pushViewController(vc, animated: true)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
