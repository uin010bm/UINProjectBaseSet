//
//  NSDateTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
@testable import UINProjectBaseSet

class NSDateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testComponents() {
        
        let date = NSDate()
        
        XCTAssertEqual(date.year, 2015, "Year is wrong :: testComponents")
        XCTAssertEqual(date.month, 10, "Month is wrong :: testComponents")
        XCTAssertEqual(date.day, 26, "Day is wrong :: testComponents")
        XCTAssertEqual(date.weekday, 2, "Day is wrong :: testComponents")
//        XCTAssertEqual(date.hour, 10, "Hour is wrong :: testComponents")
//        XCTAssertEqual(date.minute, 53, "Minute is wrong :: testComponents")
//        XCTAssertEqual(date.second, 15, "Second is wrong :: testComponents")
        
        let hour = date.hour
        let minute = date.minute
        let second = date.second
        XCTAssert(true, "hour : \(hour) - minute : \(minute) - second : \(second) :: testComponents")
        return
    }
    
    func testGetDateWithMilliSeconds() {
        let milliSecInt = NSDate.getNowIntTime()
        let milliSecDate = NSDate.getDateWithMilliSeconds(milliSecInt)
        let milliSecFromDate = Int64(milliSecDate.timeIntervalSince1970) * 1000
        XCTAssertEqual(milliSecInt, milliSecFromDate, "Date Int is not Equal - \(milliSecInt) - \(milliSecFromDate) :: testGetDateWithMilliSeconds")
    }
    
    func testGetStringWithFormatString() {
//        let date = NSDate().getStringWithFormatString("YYYY/MM/dd - hh:mm")
        let date = NSDate().getStringWithFormatString("YYYY")
//        XCTAssertEqual(date, "2015/10/15 - 11:32", "Date Convert string is failed - \(date) :: testGetStringWithFormatString")
        XCTAssertEqual(date, "2015", "Date Convert string is failed - \(date) :: testGetStringWithFormatString")
    }
    
    func testGetDiffTimeIntervalFromNow() {
        
        let expectation = self.expectationWithDescription("Test wail")
        
        let before = NSDate()
        delay(0.2, closure: {
            let interval = before.getDiffTimeIntervalFromNow()
            XCTAssertFalse(interval < 0.2, "Get time diff not working :: testGetDiffTimeIntervalFromNow")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testSetComonentsTimeZone() {
        let timezoneLocal = NSTimeZone.localTimeZone()
        let timezoneWithName = NSTimeZone(name: "America/New_York")
        
        let dateLocal = NSDate()
        
        let local = dateLocal.getConvertedDateWithTimezone(timezoneLocal)
        let america = dateLocal.getConvertedDateWithTimezone(timezoneWithName!)
        
        XCTAssertNotEqual(local.hour, america.hour, "Date timezone is equal - \(local.hour) - \(america.hour) :: testSetComonentsTimeZone")
    }
    
}