//
//  DataModelPost.swift
//  JSONPlaceholder
//
//  Created by Cédric Rolland on 17.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation
import Alamofire

protocol PostDataModelDelegate: class {
    func didReceiveDataUpdate(posts: [Post])
    func didFailDataUpdateWithError(error: Error)
}

class PostDataModel {
    
    weak var delegate: PostDataModelDelegate?
    
    func requestData(url: String, userId: Int) {
        Alamofire.request("\(url)\(userId)").responseJSON { response in
            guard response.result.isSuccess else {
                if let error = response.result.error {
                    print("Error while fetching data: \(error)")
                    self.delegate?.didFailDataUpdateWithError(error: error)
                }
                return
            }
            
            guard let responseJSON = response.result.value as? [[String: Any]] else {
                print("Invalid data received from the service")
                self.delegate?.didFailDataUpdateWithError(error: FormatError.badFormatError)
                return
            }
            
            self.setDataWithResponse(response: responseJSON)
        }
    }
    
    private func setDataWithResponse(response:[[String: Any]]) {
        print("downloaded data: \(response)")
        
        var postsArray = [Post]()
        
        for data in response {
            if let post = Post(json: data) {
                postsArray.append(post)
            }
        }
        
        delegate?.didReceiveDataUpdate(posts: postsArray)
    }
}
