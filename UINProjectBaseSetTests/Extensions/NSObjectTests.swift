//
//  NSObjectTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
@testable import UINProjectBaseSet

class NSObjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetClassNameWithoutNamespace() {
        
        let objnameFromInstance = NSObject().getClassNameWithoutNamespace()
        let objnameFromClass = NSObject.getClassNameWithoutNamespace()
        
        XCTAssertEqual(objnameFromInstance, "NSObject", "Failed get class name \(objnameFromInstance) != NSObject :: testGetClassNameWithoutNamespace")
        XCTAssertEqual(objnameFromClass, "NSObject", "Failed get class name \(objnameFromClass) != NSObject :: testGetClassNameWithoutNamespace")
        
        let projectObjFromInstance = ApplicationManager().getClassNameWithoutNamespace()
        let projectObjFromClass = ApplicationManager.getClassNameWithoutNamespace()
        
        XCTAssertEqual(projectObjFromInstance, "ApplicationManager", "Failed get class name \(objnameFromInstance) != NSObject :: testGetClassNameWithoutNamespace")
        XCTAssertEqual(projectObjFromClass, "ApplicationManager", "Failed get class name \(objnameFromClass) != NSObject :: testGetClassNameWithoutNamespace")
        
        return
    }
    
}