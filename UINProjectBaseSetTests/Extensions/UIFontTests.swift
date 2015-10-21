//
//  UIFontTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/16.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
@testable import UINProjectBaseSet

class UIFontTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHiraKakuProNW3() {
        let font = UIFont.getHiraKakuProNW3(10)
        XCTAssertNotNil(font, "HiraKakuPro font is not availed")
    }
    
    func testHiraKakuProNW6() {
        let font = UIFont.getHiraKakuProNW6(10)
        XCTAssertNotNil(font, "HiraKakuPro font is not availed")
    }
}
