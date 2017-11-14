//
//  AlamofireExtension.swift
//  Quandoo
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Alamofire

// Networking calls
extension UserListViewController {
    func downloadUsers(completion: @escaping ([[String: Any]]) -> Void) {
        Alamofire.request(
            "https://jsonplaceholder.typicode.com/users"
            )
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    if let error = response.result.error {
                        print("Error while fetching tags: \(error)")
                        completion([[String: Any]]())
                    }
                    return
                }
                
                guard let responseJSON = response.result.value as? [[String: Any]] else {
                    print("Invalid users information received from the service")
                    completion([[String: Any]]())
                    return
                }
                
                print(responseJSON)
                completion(responseJSON)
        }
    }
}
