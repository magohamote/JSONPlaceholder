//
//  UserListViewController.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {

    private var usersArray:[User] = []
    private var loadingView:UIView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x25ac72)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(downloadUsers), for: .valueChanged)
        self.tableView.refreshControl?.tintColor = UIColor(rgb: 0x25ac72)
        self.tableView.separatorColor = .clear
        
        showLoadingView()
        downloadUsers()
    }

    // MARK: - Data MGMT
    @objc private func downloadUsers() {
        Requests.shared().downloadUsers(completion: { users, error in
            if let users = users {
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
    
    // MARK: - Errors
    func showError() {
        let alertController = UIAlertController(title: "Error", message: "An error occured while downloading users", preferredStyle: UIAlertControllerStyle.alert)
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
