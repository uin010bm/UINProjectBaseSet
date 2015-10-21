//
//  UIScreenTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//


import XCTest
@testable import UINProjectBaseSet

class UIScreenTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHandleScrollRectToVisible() {
        // Test delegate to UITest
        
        let expectation = self.expectationWithDescription("Test wail")
        
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, 100, 1000))
        scrollView.handleScrollRectToVisible(CGRectMake(0, 900, 1, 100), animated: true, completion: {
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(0.5, handler: nil)
    }
}