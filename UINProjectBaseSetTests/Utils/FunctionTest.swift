//
//  FunctionTest.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/14.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
@testable import UINProjectBaseSet

class FunctionTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetiOSVersion() {
        let iosVersion = getiOSVersion()
        XCTAssertTrue(iosVersion > 0, "Unknown number arrived :: testGetiOSVersion")
        return
    }
    
    func testLog() {
        Log("Test Message")
        return
    }
    
    func testALERT() {
        ALERT(title: "TEST-TITLE", body: "TEST-BODY")
        return
    }
    
    func testRun_on_background_queue() {
        
        let expectation = self.expectationWithDescription("Test wait")
        
        run_on_background_queue({
            XCTAssertFalse(NSThread.isMainThread(), "Main thread working :: testRun_on_background_queue")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testRun_on_main_queue() {
        
        let expectation = self.expectationWithDescription("Test wait")
        
        run_on_main_queue({
            XCTAssertTrue(NSThread.isMainThread(), "Main thread not working :: testRun_on_main_queue")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testDelay() {
        
        let expectation = self.expectationWithDescription("Test wait")
        
        let before = NSDate()
        delay(0.2, closure: {
            let interval = before.getDiffTimeIntervalFromNow()
            XCTAssertFalse(interval < 0.2, "Interval not working :: testRun_on_background_queue")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    
}

