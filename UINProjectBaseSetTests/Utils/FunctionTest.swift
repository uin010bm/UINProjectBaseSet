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
        XCTAssertTrue(getiOSVersion() > 0, "Unknown number arrived :: testGetiOSVersion")
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
        dispatch_async(dispatch_get_main_queue(), {
            run_on_background_queue({
                XCTAssertFalse(NSThread.isMainThread(), "Main thread working :: testRun_on_background_queue")
            })
        })
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            run_on_background_queue({
                XCTAssertFalse(NSThread.isMainThread(), "Main thread working :: testRun_on_background_queue")
            })
        })
    }
    
    func testRun_on_main_queue() {
        dispatch_async(dispatch_get_main_queue(), {
            run_on_main_queue({
                XCTAssertTrue(NSThread.isMainThread(), "Main thread not working :: testRun_on_main_queue")
            })
        })
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            run_on_main_queue({
                XCTAssertTrue(NSThread.isMainThread(), "Main thread not working :: testRun_on_main_queue")
            })
        })

    }
    
    func testDelay() {
        let before = NSDate()
        delay(0.2, closure: {
            let interval = before.getDiffTimeIntervalFromNow()
            XCTAssertFalse(interval < 0.2, "Interval not working :: testRun_on_background_queue")
            return
        })
    }
    
    
}

