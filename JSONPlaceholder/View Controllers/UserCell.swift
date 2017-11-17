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
    
    func config(name: String, username: String, email: String, address: Address) {
        self.nameLabel.text = name
        self.usernameLabel.text = username
        self.emailLabel.text = email
        self.addressLabel.text = "\(address.street), \(address.suite)\n\(address.zipcode) \(address.city)"
        self.nameLabel.adjustsFontSizeToFitWidth = true
    }
}
