//
//  ApiClientTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/19.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
import OHHTTPStubs

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
        
        let expectation = self.expectationWithDescription("Test wail")
        
        stub(isHost("debug-api")) { _ in
            return OHHTTPStubsResponse(data: NSData(), statusCode: 403, headers: nil)
        }
        
        let model = UserListModel()
        model.getUserListFromApi({ (users: [User]?, response: Response<JSON, NSError>) in
            let errorType = ApiClient.sharedInstance.handleError(response.response!.statusCode)
            XCTAssertEqual(errorType.rawValue, "ErrorApiBadParams", "ErrorType is not 403")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
        
    }
    
    
    
}