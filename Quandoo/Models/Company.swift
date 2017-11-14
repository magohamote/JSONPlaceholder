//
//  Company.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation

class Company: NSObject {
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    init(json: [String : Any]?) {
        self.name = json?["name"] as? String
        self.catchPhrase = json?["catchPhrase"] as? String
        self.bs = json?["bs"] as? String
    }
}
