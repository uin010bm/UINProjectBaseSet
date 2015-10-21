//
//  UILabelTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//


import XCTest
@testable import UINProjectBaseSet

class UILabelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetAttributedTextWithLabelStyle() {
        
        let label = UILabel(frame: CGRectMake(0, 0, 100, 100))
        label.setAttributedTextWithLabelStyle("TEST-String", font: UIFont.getHiraKakuProNW6(10), textColor: UIColor.whiteColor(), baselineOffset: 2.0, alignment: NSTextAlignment.Center, lineBreakMode: NSLineBreakMode.ByCharWrapping, lineHeight: 2.0)
        label.setAttributedTextWithLabelStyle(nil, font: nil, textColor: nil, baselineOffset: nil, alignment: nil, lineBreakMode: nil)
        return
    }
}