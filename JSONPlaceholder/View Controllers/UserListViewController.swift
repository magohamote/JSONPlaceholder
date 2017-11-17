//
//  UserListViewController.swift
//  JSONPlaceholder
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {

    var usersArray:[User] = []
    private var loadingView:UIView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x25ac72)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(downloadUsers), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor(rgb: 0x25ac72)
        self.refreshControl?.backgroundColor = .white
        
        self.tableView.separatorColor = .clear
        
        showLoadingView()
        downloadUsers()
    }

    // MARK: - Data MGMT
    @objc private func downloadUsers() {
        Request.shared().downloadData(url: "https://jsonplaceholder.typicode.com/users", completion: { users, error in
            if let users = users {
                self.usersArray.removeAll()
                
                for user in users {
                    do {
                        try self.usersArray.append(User(json: user))
                    } catch {
                        print("An error occured while downloading users")
                        self.showError()
                    }
                }
                self.tableView.reloadData()
                
            } else {
                print("Error: \(error!)")
                self.showError()
            }
            
            self.hideLoadingView()
        })
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    // MAKR: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell {
            let user = usersArray[indexPath.row]
            cell.config(name: user.name, username: user.username, email: user.email, address: user.address)
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostListViewController") as? PostListViewController {
            
            let user = usersArray[indexPath.row]
            vc.username = user.username
            vc.userId = user.id
            
            self.navigationController?.pushViewController(vc, animated: true)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
