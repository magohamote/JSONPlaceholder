//
//  UserListViewController.swift
//  JSONPlaceholder
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UserDataModelDelegate {

    @IBOutlet var tableView: UITableView!
    
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
        setupTableView()
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoadingView()
        downloadUsers()
    }

    func setupTableView() {
        tableView.refreshControl = RefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(downloadUsers), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .clear
    }
    
    // MARK: - DataModel
    @objc private func downloadUsers() {
        dataSource.requestData(url: "https://jsonplaceholder.typicode.com/users")
    }
    
    // MARK: - UserDataModelDelegate
    func didReceiveDataUpdate(users: [User]) {
        usersArray = users
        hideLoadingView(tableView: tableView)
    }
    
    func didFailDataUpdateWithError(error: Error) {
        hideLoadingView(tableView: tableView)
        showError()
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as? UserCell {
            cell.config(user: usersArray[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PostListViewController") as? PostListViewController {
            
            vc.username = usersArray[indexPath.row].username
            vc.userId = usersArray[indexPath.row].id
            
            navigationController?.pushViewController(vc, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
