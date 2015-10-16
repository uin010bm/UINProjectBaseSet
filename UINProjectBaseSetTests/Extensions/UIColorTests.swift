//
//  UIColorTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//


import XCTest
@testable import UINProjectBaseSet

class UIColorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testColorType() {
        
        let type1 = UIColor.ColorType.Navigation
        let type2 = UIColor.ColorType.Black
        let type3 = UIColor.ColorType.White
        let type4 = UIColor.ColorType.Caution
        let type5 = UIColor.ColorType.Border
        
        XCTAssertEqual(type1.rawValue, "#050505", "Enum rawvalue is wrong :: testColorType")
        XCTAssertEqual(type2.rawValue, "#000000", "Enum rawvalue is wrong :: testColorType")
        XCTAssertEqual(type3.rawValue, "#FFFFFF", "Enum rawvalue is wrong :: testColorType")
        XCTAssertEqual(type4.rawValue, "#e40b26", "Enum rawvalue is wrong :: testColorType")
        XCTAssertEqual(type5.rawValue, "#898989", "Enum rawvalue is wrong :: testColorType")
        return
    }
    
    func testConvenienceInit() {
        
        let colorWithWhiteType = UIColor(colorType: .White)
        let colorWithBlackType = UIColor(colorType: .Black)
        let colorWithString1 = UIColor(rgba: "FFFFFF")
        let colorWithString2 = UIColor(rgba: "#U0Y0X0")
        let colorWithString3 = UIColor(rgba: "#FF")
        let colorWithString4 = UIColor(rgba: "#FFF")
        let colorWithString5 = UIColor(rgba: "#FFFF")
        let colorWithString6 = UIColor(rgba: "#FFFFFF")
        let colorWithString7 = UIColor(rgba: "#FFFFFFFF")
        
        XCTAssertEqual(colorWithString1, colorWithBlackType, "Color initialize is failed :: testConvenienceInit")
        XCTAssertEqual(colorWithString2, colorWithBlackType, "Color initialize is failed :: testConvenienceInit")
        XCTAssertEqual(colorWithString3, colorWithBlackType, "Color initialize is failed :: testConvenienceInit")
        XCTAssertEqual(colorWithString4, colorWithWhiteType, "Color initialize is failed :: testConvenienceInit")
        XCTAssertEqual(colorWithString5, colorWithWhiteType, "Color initialize is failed :: testConvenienceInit")
        XCTAssertEqual(colorWithString6, colorWithWhiteType, "Color initialize is failed :: testConvenienceInit")
        XCTAssertEqual(colorWithString7, colorWithWhiteType, "Color initialize is failed :: testConvenienceInit")
        return
    }
    
    func testGetColoredImage() {
        
        let grayImage = UIColor(white: 0.3, alpha: 1).getColoredImage()
        
        XCTAssertEqual(grayImage.getClassNameWithoutNamespace(), UIImage.getClassNameWithoutNamespace(), "Image create from UIColor failed :: testGetColoredImage")
        return
    }
    
    func testGetDarkenColor() {
        
        let whiteWithRatio = UIColor(white: 1, alpha: 1)
        let whiteWithString = UIColor(rgba: "#FFF")
        let darkenWhite1 = whiteWithRatio.getDarkenColor()
        let darkenWhite2 = whiteWithString.getDarkenColor()
        
        XCTAssertEqual(darkenWhite1, darkenWhite2, "Create dark color from UIColor failed :: testGetDarkenColor")
        return
    }
    
    func testGetDarkenColorWithRatio() {
        let white = UIColor(white: 1, alpha: 1)
        let black = UIColor(white: 0, alpha: 1)
        let darkenWhite = white.getDarkenColorWithRatio(0)
        let darkenBlack = black.getDarkenColorWithRatio(0)
        
        XCTAssertEqual(darkenWhite, darkenBlack, "Create dark color from HUE failed :: testGetDarkenColorWithRatio")
        return
    }
    
}