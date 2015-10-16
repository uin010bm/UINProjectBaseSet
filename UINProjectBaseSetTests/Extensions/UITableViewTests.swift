//
//  UITableViewTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//


import XCTest
@testable import UINProjectBaseSet

class UITableViewTests: XCTestCase {
    
    private let tableView = UITableView(frame: CGRectMake(0, 0, 100, 1000))
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsLastRowVisible() {
        // Should Test on UITesting!!
        
        let isVisibledLastCell = self.tableView.isLastRowVisible
        XCTAssertFalse(isVisibledLastCell, "Last cell is not showed")
    }
    
    func testScrollToBottom() {
        // Should Test on UITesting!!
        
        self.tableView.scrollToBottom()
    }
    
    func testScrollToTop() {
        // Should Test on UITesting!!
        
        self.tableView.scrollToTop()
    }
    
    func testRegisterNibFromClass() {
        // Should Test on UITesting!!
        
        self.tableView.registerNibFromClass(UITableViewCell)
        self.tableView.registerCellClassFromClass(UITableViewCell)
    }
    
}
