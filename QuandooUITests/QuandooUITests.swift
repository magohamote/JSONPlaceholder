//
//  QuandooUITests.swift
//  QuandooUITests
//
//  Created by Rolland Cédric on 14.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import XCTest

class QuandooUITests: XCTestCase {
    
    var app:XCUIApplication? = nil
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        XCUIApplication().launch()

        app = XCUIApplication()
    }
    
    override func tearDown() {
        
        app = nil
        
        super.tearDown()
    }
    
    func testUsersAndPosts() {
        guard let app = app else {
            XCTFail()
            return
        }
        
        let usersTable = app.tables["usersTable"]
        XCTAssertNotNil(usersTable)
        
        usersTable.cells.staticTexts["Bret"].tap()
        
        let postsTable = app.tables["postsTable"]
        XCTAssertNotNil(postsTable)
        let postCell = postsTable.cells["qui est esse"]
        XCTAssertNotNil(postCell)
        
        postsTable.swipeUp()
    }
}
