//
//  UserTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/20.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
import OHHTTPStubs

@testable import UINProjectBaseSet

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testUserStruct() {
        
        let expectation = self.expectationWithDescription("Test wail")
        
        stub(isHost("debug-api")) { _ in
            let stubPath = OHPathForFile("StubUserApi.json", self.dynamicType)
            return fixture(stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        UserService.getUserFromApi("Testちゃん", completion: { (user: User?, errorType: ApiErrorType) in
            XCTAssertEqual(user!.name, "Testちゃん", "Api response is wrong. \(user!.name)")
            
            let nUser = User(json: user!.json)
            XCTAssertEqual(nUser!.name, "Testちゃん", "Api response is wrong. \(nUser!.name)")
            
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(20.0, handler: nil)
    }
    
    func testUserListModel() {
        
        let expectation = self.expectationWithDescription("Test wail")
        
        stub(isHost("debug-api")) { _ in
            let stubPath = OHPathForFile("StubUserListApi.json", self.dynamicType)
            return fixture(stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        let model = UserListModel()
        model.getUserListFromApi({ (users: [User]?, errorType: ApiErrorType) in
            XCTAssertEqual(users![0].name, "TestList1ちゃん", "Api response is wrong. \(users![0].name)")
            XCTAssertEqual(errorType.rawValue, 200, "ErrorType is not None")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(20.0, handler: nil)
    }
    
    func testUserListModelFailed() {
        
        let expectation = self.expectationWithDescription("Test wail")
        
        stub(isHost("debug-api")) { _ in
            return OHHTTPStubsResponse(data: NSData(), statusCode: 500, headers: nil)
        }
        
        let model = UserListModel()
        model.getUserListFromApi({ (users:[User]?, errorType: ApiErrorType) in
            XCTAssertEqual(errorType.rawValue, 500, "ErrorType is not unknown")
            XCTAssertNil(users, "Api response is not error.")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
        
    }
    
}