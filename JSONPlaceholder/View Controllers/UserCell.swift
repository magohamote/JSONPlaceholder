//
//  UserCell.swift
//  JSONPlaceholder
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    class var identifier: String {
        return String(describing: self)
    }
    
    func config(user: User) {
        self.nameLabel.text = user.name
        self.usernameLabel.text = user.username
        self.emailLabel.text = user.email
        self.addressLabel.text = "\(user.address.street), \(user.address.suite)\n\(user.address.zipcode) \(user.address.city)"
        self.nameLabel.adjustsFontSizeToFitWidth = true
    }
}
