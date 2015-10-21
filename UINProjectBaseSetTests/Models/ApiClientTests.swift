//
//  ApiClientTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/19.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
import Alamofire

@testable import UINProjectBaseSet

class ApiClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAlamoFireManager() {
        
        let manager = ApiClient.sharedInstance.alamoFireManager
        XCTAssertEqual(manager?.session.configuration.timeoutIntervalForRequest, 4, "Manager setup is failed :: testAlamoFireManager")
        return
    }
    
    
    func testHandleError() {
        // Test delegate to User
    }
    
    
    
}