//
//  UserCell.swift
//  Quandoo
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
    
    func config(name: String?, username: String?, email: String?, address: Address?) {
        self.nameLabel.text = name
        self.usernameLabel.text = username
        self.emailLabel.text = email
        if let address = address, let street = address.street, let suite = address.suite, let zipcode = address.zipcode, let city = address.city {
            self.addressLabel.text = "\(street), \(suite)\n\(zipcode) \(city)"
        } else {
            self.addressLabel.text = "error"
        }
    }
    
}
