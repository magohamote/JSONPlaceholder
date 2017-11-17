//
//  User.swift
//  JSONPlaceholder
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation

class User: NSObject {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String?
    var website: String?
    var company: Company?
    
    init(json: [String : Any]?) throws {
        if let id = json?["id"] as? Int,
           let name = json?["name"] as? String,
           let username = json?["username"] as? String,
           let email = json?["email"] as? String,
           let address = json?["address"] as? [String: Any] {
            self.id = id
            self.name = name
            self.username = username
            self.email = email
            try self.address = Address(json: address)
        } else {
            throw FormatError.badFormatError
        }
        
        self.phone = json?["phone"] as? String
        self.website = json?["website"] as? String
        self.company = Company(json: json?["company"] as? [String: Any])
    }
}
