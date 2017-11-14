//
//  Address.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation

struct Geo {
    var lat: Double?
    var lng: Double?
    
    init(json: [String : Any]?) {
        self.lat = json?["lat"] as? Double
        self.lng = json?["lng"] as? Double
    }
}

class Address: NSObject {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
    
    init(json: [String : Any]?) throws {
        self.street = json?["street"] as? String
        self.suite = json?["suite"] as? String
        self.city = json?["city"] as? String
        self.zipcode = json?["zipcode"] as? String
        
        guard let geo = json?["geo"] as? [String: Any]? else {
            throw FormatError.badFormatError
        }
        
        self.geo = Geo(json: geo)
    }
}
