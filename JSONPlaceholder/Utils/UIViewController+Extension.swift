//
//  UIViewController+Extension.swift
//  JSONPlaceholder
//
//  Created by Cédric Rolland on 17.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {
    
    // MARK: - Errors
    func showError() {
        let alertController = UIAlertController(title: "Error", message: "An error occured while downloading users", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Loading
    func showLoadingView() {
        let loadingView = UIView(frame: self.view.bounds)
        loadingView.tag = 42
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
        self.tableView.separatorColor = UIColor(rgb: 0x25ac72)
        self.refreshControl?.endRefreshing()
        self.view.viewWithTag(42)?.removeFromSuperview()
    }
}
