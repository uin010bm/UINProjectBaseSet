//
//  StringTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
@testable import UINProjectBaseSet

class StringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCheckValidPassword() {
        
        let check1 = String.checkValidPassword("12345")
        let check2 = String.checkValidPassword("123456")
        
        XCTAssertFalse(check1, "Check must be false :: testCheckValidPassword")
        XCTAssertTrue(check2, "Check must be true :: testCheckValidPassword")
        return
    }
    
    func testCheckValidEmail() {
        
        let check1 = String.checkValidEmail("0000000000")
        let check2 = String.checkValidEmail("aaa@mm.mm.mm")
        
        XCTAssertFalse(check1, "Check must be false :: testCheckValidEmail")
        XCTAssertTrue(check2, "Check must be true :: testCheckValidEmail")
        return
    }
    
    func testConvertUrlEncoded() {
        
        let before = "テスト"
        let after = before.convertUrlEncoded()
        
        XCTAssertEqual(after, "%E3%83%86%E3%82%B9%E3%83%88", "UTF-8 encode is failed - \(after) :: testConvertUrlEncoded")
        return
    }
    
    func testConvertUrlDecoded() {
        
        let before = "%E3%83%86%E3%82%B9%E3%83%88"
        let after = before.convertUrlDecoded()
        
        XCTAssertEqual(after, "テスト", "UTF-8 decode is failed - \(after) :: testConvertUrlEncoded")
        return
    }
    
    func testGetSubstringToIndex() {
        
        let str = "123456789"
        let substr1 = str.getSubstringToIndex(5)
        let substr2 = str.getSubstringToIndex(12)
        
        XCTAssertEqual(substr1, "12345", "Get substring is failed - \(substr1) :: testGetSubstringToIndex")
        XCTAssertEqual(substr2, "123456789", "Get substring is failed - \(substr2) :: testGetSubstringToIndex")
        return
    }
    
    func testGetSize() {
        
        let str1 = "あ"
        let str2 = "あああああああああああああああああああああああああああ"
        let size1 = str1.getSize(UIFont.hiraKakuProNW6(10), lineBreakMode: NSLineBreakMode.ByCharWrapping, lineHeight: 1.0, constrainedToSize: CGSize(width: 10, height: 10000))
        let size2 = str2.getSize(UIFont.hiraKakuProNW6(10), lineBreakMode: NSLineBreakMode.ByCharWrapping, lineHeight: 2.0, constrainedToSize: CGSize(width: 10, height: 10000))
        
        XCTAssertEqual(size1.height, 10, "Minimum size is wrong - \(size1.height) :: testGetSize")
        XCTAssertGreaterThan(size2.height, 10, "Rect size is wrong - \(size2.height) :: testGetSize")
        return
    }
    
    func testGetConvertEndToEllipsisAtCount() {
        
        let beforeStr = "123456789"
        let afterStr1 = beforeStr.getConvertEndToEllipsisAtCount(5)
        let afterStr2 = beforeStr.getConvertEndToEllipsisAtCount(10)
        
        XCTAssertEqual(afterStr1, "12345...", "Ellipsis is wrong - \(afterStr1) :: testGetConvertEndToEllipsisAtCount")
        XCTAssertEqual(afterStr2, "123456789", "Ellipsis is wrong - \(afterStr2) :: testGetConvertEndToEllipsisAtCount")
        return
    }
    
    func testGetPathAppendedComponentWithPath() {
        let basePathStr = "~/hoge/hoge.hoge"
        let addedPathStr = basePathStr.getPathAppendedComponentWithPath("fuga")
        
        XCTAssertEqual(addedPathStr, "~/hoge/hoge.hoge/fuga", "Path is wrong - \(addedPathStr) :: testGetPathAppendedComponentWithPath")
        return
    }
    
}