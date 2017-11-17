//
//  Address.swift
//  JSONPlaceholder
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
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo?
    
    init?(json: [String : Any]?) {
        if let street = json?["street"] as? String,
           let suite = json?["suite"] as? String,
           let city = json?["city"] as? String,
           let zipcode = json?["zipcode"] as? String {
            self.street = street
            self.suite = suite
            self.city = city
            self.zipcode = zipcode
        } else {
            return nil
        }
        
        self.geo = Geo(json: json?["geo"] as? [String: Any])
    }
}
