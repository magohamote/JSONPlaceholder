//
//  Request.swift
//  QuandooTests
//
//  Created by Rolland Cédric on 15.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation

public class Request {
    
    var request:String?
    
    struct response{
        static var data:HTTPURLResponse?
        static var json:AnyObject?
        static var error:NSError?
    }
    
    init (request: String){
        self.request = request
    }
    
    public func responseJSON(options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: (NSURLRequest, HTTPURLResponse?, AnyObject?, NSError?) -> Void) -> Self {
        
        completionHandler(NSURLRequest(url: NSURL(string:self.request!)! as URL), Request.response.data, Request.response.json, Request.response.error)
        return self
    }
}
