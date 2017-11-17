//
//  Post.swift
//  JSONPlaceholder
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation

class Post: NSObject {
    var userId: Int
    var id: Int?
    var title: String
    var body: String
    
    init(json: [String : Any]?) throws {
        if let userId = json?["userId"] as? Int,
           let title = json?["title"] as? String,
           let body = json?["body"] as? String {
            self.userId = userId
            self.title = title
            self.body = body
        } else {
            throw FormatError.badFormatError
        }
        
        self.id = json?["id"] as? Int
    }
}
