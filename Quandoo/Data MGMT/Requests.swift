//
//  Requests.swift
//  Quandoo
//
//  Created by Rolland Cédric on 15.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation
import Alamofire

class Requests {
    
    private static let requests = Requests()
    
    private init(){}
    
    class func shared() -> Requests {
        return requests
    }
    
    func downloadUsers(completion: @escaping (_ data: [[String: Any]]?, _ error: Error?) -> Void) {
        
        request("https://jsonplaceholder.typicode.com/users").responseJSON { response in
            
            guard response.result.isSuccess else {
                if let error = response.result.error {
                    print("Error while fetching tags: \(error)")
                    completion(nil, error)
                }
                return
            }
            
            guard let responseJSON = response.result.value as? [[String: Any]] else {
                print("Invalid users information received from the service")
                completion(nil, FormatError.badFormatError)
                return
            }
            
            completion(responseJSON, nil)
        }
    }
    
    func downloadUsersPosts(userId: Int, completion: @escaping (_ data: [[String: Any]]?, _ error: Error?) -> Void) {
        
        request("https://jsonplaceholder.typicode.com/posts?userId=\(userId)").responseJSON { response in
            
            guard response.result.isSuccess else {
                if let error = response.result.error {
                    print("Error while fetching tags: \(error)")
                    completion(nil, error)
                }
                return
            }
            
            guard let responseJSON = response.result.value as? [[String: Any]] else {
                print("Invalid users information received from the service")
                completion(nil, FormatError.badFormatError)
                return
            }
            
            completion(responseJSON, nil)
        }
    }
}
