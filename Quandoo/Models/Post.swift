//
//  Post.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation

class Post: NSObject {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    init(json: [String : Any]?) {
        self.userId = json?["userId"] as? Int
        self.id = json?["id"] as? Int
        self.title = json?["title"] as? String
        self.body = json?["body"] as? String
    }
}
