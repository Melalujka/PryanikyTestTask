//
//  PryanikyTestTaskUITests.swift
//  PryanikyTestTaskUITests
//
//  Created by Melalujka on 30.09.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import XCTest

class PryanikyTestTaskUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    func testExample() throws {
        
        let tableView = XCUIApplication().tables
        print("tableView.cells.count \(tableView.cells.count)")
        app.
        XCTAssert(tableView.cells.count == 4)
    }
}
