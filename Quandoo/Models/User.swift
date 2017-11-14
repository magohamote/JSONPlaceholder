//
//  User.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation

class User: NSObject {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
    
    init(json: [String : Any]?) throws {
        self.id = json?["id"] as? Int
        self.name = json?["name"] as? String
        self.username = json?["username"] as? String
        self.email = json?["email"] as? String
        self.phone = json?["phone"] as? String
        self.website = json?["website"] as? String
        
        guard let address = json?["address"] as? [String: Any]?, let company = json?["company"] as? [String: Any]? else {
            throw FormatError.badFormatError
        }
        
        try self.address = Address(json: address)
        self.company = Company(json: company)
    }
}
