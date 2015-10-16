//
//  ViewControllerTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/16.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class ViewControllerTests: XCTestCase {
        
    override func setUp() {
        if kTargetController.rawValue != "\(self.dynamicType)" {
            return
        }
        
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        if kTargetController.rawValue != "\(self.dynamicType)" {
            return
        }
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        if kTargetController.rawValue != "\(self.dynamicType)" {
            return
        }
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let button = app.otherElements.containingType(.NavigationBar, identifier:"UINProjectBaseSet.View").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Button).matchingIdentifier("Button").elementBoundByIndex(0)
        let button2 = app.otherElements.containingType(.NavigationBar, identifier:"UINProjectBaseSet.View").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Button).matchingIdentifier("Button").elementBoundByIndex(1)
        button.tap()
        
        let image = app.scrollViews.childrenMatchingType(.Image).elementBoundByIndex(0)
        image.swipeDown()
        image.swipeUp()
        button.tap()
        button2.tap()
        
    }
    
}
