//
//  PostCell.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var titleHeightConstraint: NSLayoutConstraint!
    @IBOutlet var bodyHeightConstraint: NSLayoutConstraint!
    
    func config(title: String?, body: String?) {
        self.titleLabel.text = title
        self.bodyLabel.text = body
        self.titleHeightConstraint.constant = titleLabel.retrieveTextHeight()
        self.bodyHeightConstraint.constant = bodyLabel.retrieveTextHeight()
    }
}

