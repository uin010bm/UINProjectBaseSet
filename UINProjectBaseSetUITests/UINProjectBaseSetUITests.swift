//
//  UINProjectBaseSetUITests.swift
//  UINProjectBaseSetUITests
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest

public enum TargetController: String {
    case ViewController = "ViewControllerTests",
    SecondViewController = "SecondViewControllerTests"
}

public let kTargetController = TargetController.SecondViewController

@available(iOS 9.0, *)
class UINProjectBaseSetUITests: XCTestCase {
        
    override func setUp() {
        if kTargetController.rawValue != "\(self.dynamicType)" {
            return
        }
        
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

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
    }
    
}
