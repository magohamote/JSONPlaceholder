//
//  UserListViewController.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {

    var usersArray:[User] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x25ac72)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        downloadUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Data MGMT
    func downloadUsers() {
        downloadUsers(completion: { users in
            for user in users {
                do {
                    try self.usersArray.append(User(json: user))
                } catch {
                    print("An error occured while downloading users")
                }
            }
            
            self.tableView.reloadData()
        })
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell {
            let user = usersArray[indexPath.row]
            cell.config(name: user.name, username: user.username, email: user.email, address: user.address)
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
