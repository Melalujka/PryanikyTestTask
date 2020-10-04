//
//  PryanikyTestTaskTests.swift
//  PryanikyTestTaskTests
//
//  Created by Melalujka on 30.09.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import XCTest
@testable import PryanikyTestTask


class PryanikyTestTaskTests: XCTestCase {
    
    var sut: TestPresenter!

    override func setUp() {
        super.setUp()
        
        sut = TestPresenter(view: MockTestView(), network: MockNetworkService())
        sut.viewReady()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPresenterSourceContentSize() {
        XCTAssertEqual(sut.source.count, 5, "Source size not correct")
    }
    
    func testPresenterSourceContent() {
        guard case .picture(title: _, url: let urlString) = sut.source[2] else {
            XCTFail("Source data decoding with mistakes")
            return
        }
        XCTAssertEqual(urlString, "https://pryaniky.com/static/img/logo-a-512.png", "Source data decoding with mistakes")
        
    }
}
