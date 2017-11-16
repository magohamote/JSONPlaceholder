//
//  Requests.swift
//  Quandoo
//
//  Created by Rolland Cédric on 15.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    
    private static let request = Request()
    
    private init(){}
    
    class func shared() -> Request {
        return request
    }
    
    func downloadData(url: String, userId: Int? = nil, completion: @escaping (_ data: [[String: Any]]?, _ error: Error?) -> Void) {
        
        let userIdString = (userId != nil) ? String(userId!) : ""
        Alamofire.request("\(url)\(userIdString)").responseJSON { response in
            
            guard response.result.isSuccess else {
                if let error = response.result.error {
                    print("Error while fetching data: \(error)")
                    completion(nil, error)
                }
                return
            }
            
            guard let responseJSON = response.result.value as? [[String: Any]] else {
                print("Invalid data received from the service")
                completion(nil, FormatError.badFormatError)
                return
            }
            print("downloaded data: \(responseJSON)")
            completion(responseJSON, nil)
        }
    }
}
