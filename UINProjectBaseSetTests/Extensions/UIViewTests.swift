//
//  UIViewTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/16.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//


import XCTest
@testable import UINProjectBaseSet

class UIViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewShape() {
        
        let type1 = UIView.ViewShape.Circle
        let type2 = UIView.ViewShape.RoundedCorner
        
        XCTAssertEqual(type1.hashValue, 0, "ViewShapeType is not Circle.")
        XCTAssertEqual(type2.hashValue, 1, "ViewShapeType is not RoundedCorner.")
        return
    }
    
    func testViewFilter() {
        
        let type1 = UIView.ViewFilter.DarkEdgeVirtical
        let type2 = UIView.ViewFilter.BlurredVirtical
        
        XCTAssertEqual(type1.rawValue, 1, "ViewFilterType is not DarkEdgeVirtical.")
        XCTAssertEqual(type2.rawValue, 2, "ViewFilterType is not BlurredVirtical.")
        return
    }
    
    func testDropShadowType() {
        
        let type1 = UIView.DropShadowType.Rect
        let type2 = UIView.DropShadowType.Circle
        let type3 = UIView.DropShadowType.Dynamic
        
        XCTAssertEqual(type1.hashValue, 0, "DropShadowType is not Rect.")
        XCTAssertEqual(type2.hashValue, 1, "DropShadowType is not Circle.")
        XCTAssertEqual(type3.hashValue, 2, "DropShadowType is not Dynamic.")
        return
    }
    
    func testBorderPosition() {
        
        let nilLiteral = UIView.BorderPositions(nilLiteral: ())
        let setValue = UIView.BorderPositions(rawValue: 0)
        let mask = UIView.BorderPositions.fromMask(0)
        let allZero = UIView.BorderPositions.allZeros
        let top = UIView.BorderPositions.Top
        let left = UIView.BorderPositions.Left
        let bottom = UIView.BorderPositions.Bottom
        let right = UIView.BorderPositions.Right
        
        XCTAssertEqual(nilLiteral.rawValue, 0, "BorderPosition is not 0 - \(nilLiteral.rawValue)")
        XCTAssertEqual(setValue.rawValue, 0, "BorderPosition is not 0 - \(setValue.rawValue)")
        XCTAssertEqual(mask.rawValue, 0, "BorderPosition is not 0 - \(mask.rawValue)")
        XCTAssertEqual(allZero.rawValue, 0, "BorderPosition is not allZero - \(allZero.rawValue)")
        XCTAssertEqual(top.rawValue, 1, "BorderPosition is not top - \(top.rawValue)")
        XCTAssertEqual(left.rawValue, 2, "BorderPosition is not top - \(left.rawValue)")
        XCTAssertEqual(bottom.rawValue, 4, "BorderPosition is not top - \(bottom.rawValue)")
        XCTAssertEqual(right.rawValue, 8, "BorderPosition is not top - \(right.rawValue)")
        return
    }
    
    func testGetProgress() {
        
        let overProgress = UIView.getProgress(start: 0, end: 1000, current: 1100, allowOverflow: true)
        XCTAssertEqual(overProgress, 1.1, "Get progress failed - \(overProgress)")
        
        let progress = UIView.getProgress(start: 0, end: 1000, current: 100, allowOverflow: false)
        XCTAssertEqual(progress, 0.1, "Get progress failed - \(progress)")
    }
    
    func testGetProgressValue() {
        
        let progressValue = UIView.getProgressValue(start: 0, end: 1000, progress: 0.5)
        XCTAssertEqual(progressValue, 500, "Get progressValue failed - \(progressValue)")
    }
    
    func testGetInnerShadow() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        let imageView = view.getInnerShadow()
        XCTAssertNotNil(imageView, "Get shadow is failed.")
    }
    
    func testConvertShape() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        view.convertShape(.Circle)
        XCTAssertNotNil(view, "Converted is failed.")
        
        view.convertShape(.RoundedCorner)
        XCTAssertNotNil(view, "Converted is failed.")
    }
    
    func testGetImageContextFromView() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        let image = view.getImageContextFromView()
        
        XCTAssertEqual(image.getClassNameWithoutNamespace(), "UIImage", "Get image from view is failed.")
    }
    
    func testAddBorder() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        view.addBorder(.Top, width: 1, color: UIColor.blackColor())
        view.addBorder(.Left, width: 1, color: UIColor.blackColor())
        view.addBorder(.Right, width: 1, color: UIColor.blackColor())
        view.addBorder(.Bottom, width: 1, color: UIColor.blackColor())
        XCTAssertNotNil(view, "Add border is failed.")
    }
    
    func testFadeIn() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        view.hidden = true
        view.fadeIn(0.1, completion: {
            XCTAssertEqual(view.alpha, 1.0, "Fade in animation is failed.")
        })
    }
    
    func testFadeOut() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        view.fadeIn(0.1, completion: {
            XCTAssertEqual(view.alpha, 1.0, "Fade in animation is failed.")
        })
    }
    
    func testHeartBeat() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        view.heartBeat()
    }
    
    func testPopAnimation() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        view.startPopAnimation()
        view.stopPopAnimation()
    }
    
    func testBounceAnimation() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        view.bounceAnimation()
    }
    
    func testAddDropShadow() {
        // Should Test with UITesting.
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        view.addDropShadow(.Circle, color: UIColor.blackColor(), shadowOffset: CGSizeMake(1, 1))
        view.addDropShadow(.Rect, color: UIColor.blackColor(), shadowOffset: CGSizeMake(1, 1))
        view.addDropShadow(.Dynamic, color: UIColor.blackColor(), shadowOffset: CGSizeMake(1, 1))
    }
    
    func testAddDropShadowForIcon() {
        // Should Test with UITesting.
        
        let iconView = UIView(frame: CGRectMake(0, 0, 100, 100))
        iconView.addDropShadowForIcon()
    }
    
    
}
