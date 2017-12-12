//
//  JSONPlaceholderTests.swift
//  JSONPlaceholderTests
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import XCTest
import Foundation
import Alamofire

@testable import JSONPlaceholder

class JSONPlaceholderTests: XCTestCase {
    
    var userListVC: UserListViewController!
    var postListVC: PostListViewController!
    var htmlResponse: HTTPURLResponse!
    
    override func setUp() {
        super.setUp()
        userListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        postListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostListViewController") as! PostListViewController
        postListVC.userId = 1
        postListVC.username = "test"
        
        userListVC.viewDidLoad()
        postListVC.viewDidLoad()
        
        userListVC.usersArray = []
        postListVC.postsArray = []
        
        htmlResponse = HTTPURLResponse(url: NSURL(string: "dummyURL")! as URL, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
    }
    
    override func tearDown() {
        userListVC = nil
        postListVC = nil
        super.tearDown()
    }
    
    func testGoodUsersJSON() {
        let data = getTestData(name: "users")
        MockRequest.response.data = htmlResponse
        
        do {
            MockRequest.response.json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
        } catch {
            print(error)
        }
        
        _ = request("dummyURL").responseJSON { (request, response, JSON, error) -> Void in
            if let users = JSON as? [[String: Any]]{
                for user in users {
                    if let user = User(json: user) {
                        userListVC.usersArray.append(user)
                    }
                }
                
                XCTAssertEqual(userListVC.usersArray.count, 10)
            }
        }
    }
    
    func testGoodPostsJSON() {
        let data = getTestData(name: "posts")
        MockRequest.response.data = htmlResponse
        
        do {
            MockRequest.response.json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
        } catch {
            print(error)
        }
        
        _ = request("dummyURL").responseJSON { (request, response, JSON, error) -> Void in
            if let posts = JSON as? [[String: Any]]{
                for post in posts {
                    if let post = Post(json: post) {
                        postListVC.postsArray.append(post)
                    }
                }
                
                XCTAssertEqual(postListVC.postsArray.count, 10)
            }
        }
    }
    
    func testBadURLResquest() {
        Request.shared().downloadData(url: "badUrl", completion: { data, error in
            XCTAssertNotNil(error)
            XCTAssertNil(data)
        })
    }
    
    func testBadUsersJSON() {
        let data = getTestData(name: "badUsersJSON")
        MockRequest.response.data = htmlResponse
        
        do {
            MockRequest.response.json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
        } catch {
            print(error)
        }
        
        _ = request("dummyURL").responseJSON { (request, response, JSON, error) -> Void in
            if let users = JSON as? [[String: Any]]{
                for user in users {
                    do {
                        try userListVC.usersArray.append(User(json: user))
                        XCTAssertThrowsError(FormatError.badFormatError)
                    } catch {
                        print("error")
                        userListVC.showError()
                    }
                }
                
                XCTAssertEqual(userListVC.usersArray.count, 0)
            }
        }
    }
    
    func testUsersWithoutAddress() {
        let data = getTestData(name: "usersWithoutAddress")
        MockRequest.response.data = htmlResponse
        
        do {
            MockRequest.response.json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
        } catch {
            print(error)
        }
        
        _ = request("dummyURL").responseJSON { (request, response, JSON, error) -> Void in
            if let users = JSON as? [[String: Any]]{
                for user in users {
                    do {
                        try userListVC.usersArray.append(User(json: user))
                        XCTAssertThrowsError(FormatError.badFormatError)
                    } catch {
                        print("error")
                        userListVC.showError()
                    }
                }
                
                XCTAssertEqual(userListVC.usersArray.count, 0)
            }
        }
    }
    
    func testUsersWithBadAddress() {
        let data = getTestData(name: "usersWithBadAddress")
        MockRequest.response.data = htmlResponse
        
        do {
            MockRequest.response.json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
        } catch {
            print(error)
        }
        
        _ = request("dummyURL").responseJSON { (request, response, JSON, error) -> Void in
            if let users = JSON as? [[String: Any]]{
                for user in users {
                    XCTAssertNil(User(json: user))
                }
                
                XCTAssertEqual(userListVC.usersArray.count, 0)
            }
        }
    }
    
    func testBadPostsJSON() {
        let data = getTestData(name: "badPostsJSON")
        MockRequest.response.data = htmlResponse
       
        do {
            MockRequest.response.json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
        } catch {
            print(error)
        }
        
        _ = request("dummyURL").responseJSON { (request, response, JSON, error) -> Void in
            if let posts = JSON as? [[String: Any]]{
                for post in posts {
                    XCTAssertNil(Post(json: post))
                }
                
                XCTAssertEqual(postListVC.postsArray.count, 0)
            }
        }
    }
    
    private func getTestData(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: name, ofType: "json")
        return try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
    }
    
    private func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> MockRequest {
        
        return MockRequest(request: url as! String)
    }
}
