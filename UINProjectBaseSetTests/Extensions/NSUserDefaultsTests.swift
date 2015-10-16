//
//  NSUserDefaultsTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
@testable import UINProjectBaseSet

class NSUserDefaultsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetObjectForKey() {
        
        let str = "TEST"
        let num: Int = 100
        let obj = ["stringObject":str, "numObject":num]
        NSUserDefaults.standardUserDefaults().setObjectWithKey(obj, key: "test-save")
        if let getObj = NSUserDefaults.standardUserDefaults().getObjectForKey("test-save") as? [String: AnyObject]! {
            if let getStr = getObj["stringObject"] as? String!, getNum = getObj["numObject"] as? Int! {
                XCTAssertEqual(getStr, "TEST", "Failed get saved string :: testSetObjectForKey")
                XCTAssertEqual(getNum, 100, "Failed get saved string :: testSetObjectForKey")
                
                let nilObj = NSUserDefaults.standardUserDefaults().getObjectForKey("hogehogehoge")
                XCTAssertNil(nilObj, "Value must be nil")
                
                return
            }
        }
        
        XCTAssert(false, "UserDefault is not working :: testSetObjectForKey")
        return
    }
    
}