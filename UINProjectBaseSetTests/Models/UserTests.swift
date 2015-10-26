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
        
        UserService.getUserFromApi("Testちゃん", completion: { response in
            XCTAssertEqual(response.request!.URL, NSURL(string: "https://debug-api/user?name=Test%E3%81%A1%E3%82%83%E3%82%93"), "Request url create is failed.")
            XCTAssertEqual(response.result.value!.name, "Testちゃん", "Api response is wrong. \(response.result.value!.name)")
            
            let json = JSON(data: response.data!)
            let nUser = User(json: json)
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
        model.getUserListFromApi({ (users: [User]?, response: Response<JSON, NSError>) in
            XCTAssertEqual(users![0].name, "TestList1ちゃん", "Api response is wrong. \(users![0].name)")
            let errorType = ApiClient.sharedInstance.handleError(response.response!.statusCode)
            XCTAssertEqual(errorType.rawValue, "ErrorNone", "ErrorType is not None")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(20.0, handler: nil)
    }
    
    func testUserListModelFailed() {
        
        let expectation = self.expectationWithDescription("Test wail")
        
        stub(isHost("debug-api")) { _ in
            return OHHTTPStubsResponse(data: NSData(), statusCode: 404, headers: nil)
        }
        
        let model = UserListModel()
        model.getUserListFromApi({ (users:[User]?, response: Response<JSON, NSError>) in
            let errorType = ApiClient.sharedInstance.handleError(response.response!.statusCode)
            XCTAssertEqual(errorType.rawValue, "ErrorApiUnknown", "ErrorType is not unknown")
            XCTAssertNil(users, "Api response is not error.")
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
        
    }
    
}