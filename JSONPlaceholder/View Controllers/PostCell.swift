//
//  PostCell.swift
//  JSONPlaceholder
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
    
    class var identifier: String {
        return String(describing: self)
    }
    
    func config(post: Post) {
        self.titleLabel.text = post.title
        self.bodyLabel.text = post.body
        self.titleHeightConstraint.constant = titleLabel.retrieveTextHeight()
        self.bodyHeightConstraint.constant = bodyLabel.retrieveTextHeight()
    }
    
    override func prepareForReuse() {
        self.titleHeightConstraint.constant = 23
        self.bodyHeightConstraint.constant = 100
    }
}

