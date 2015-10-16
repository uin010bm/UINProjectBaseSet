//
//  ApplicationManagerTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/14.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import XCTest
@testable import UINProjectBaseSet

class ApplicationManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSharedInstance() {
        
        XCTAssertNotNil(ApplicationManager.sharedInstance, "There is no instance about :: sharedInstance")
        return
    }
    
    func testApplicationManagerIsLandscape() {
        
        let isLandscape = ApplicationManager.sharedInstance.isLandscape
        ApplicationManager.sharedInstance.setApplicationToOrientation(.LandscapeLeft)
        delay(0.5, closure: {
            XCTAssertTrue(isLandscape, "Application is not Portrate")
        })
        
        ApplicationManager.sharedInstance.setApplicationToOrientation(.Portrait)
        delay(0.5, closure: {
            XCTAssertFalse(isLandscape, "Application is Landscape")
        })
    }
    
    func testIsPortrait() {
        
        let isPortrait = ApplicationManager.sharedInstance.isPortrait
        ApplicationManager.sharedInstance.setApplicationToOrientation(.LandscapeLeft)
        delay(0.5, closure: {
            XCTAssertFalse(isPortrait, "Application is Portrate")
        })
        
        ApplicationManager.sharedInstance.setApplicationToOrientation(.Portrait)
        delay(0.5, closure: {
            XCTAssertTrue(isPortrait, "Application is not Portrate")
        })
    }
    
    func testIsEnablePush() {
        // Alertのuser許可を切り替えてテスト
        
        let isEnabledPush = ApplicationManager.sharedInstance.isEnablePush
        XCTAssertTrue(isEnabledPush, "User Push permission is false :: testIsEnablePush")
//        XCTAssertFalse(isEnabledPush, "User Push permission is ture :: testIsEnablePush")
        return
        
    }
    
    func testIsConnectedToNetwork() {
        // Network環境を切り替えてテスト
        
        let isConnected = ApplicationManager.sharedInstance.isConnectedToNetwork
        XCTAssertTrue(isConnected, "Network connected :: testIsConnectedToNetwork")
//        XCTAssertFalse(isConnected, "Network not connected :: testIsConnectedToNetwork")
    }
    
    func testIsEnableMicrophone() {
        // Micのuser許可を切り替えてテスト
        
        let isEnabledMic = ApplicationManager.sharedInstance.isEnableMicrophone
//        XCTAssertTrue(isEnabledMic, "Microphone is not enabled")
        XCTAssertFalse(isEnabledMic, "Microphone is enabled")
    }
    
    func testIsEnableNotification() {
        // Noti登録・未登録の端末を切り替えてテスト
        
        let isEnableNoti = ApplicationManager.sharedInstance.isEnableNotification
//        XCTAssertTrue(isEnableNoti, "Noti Resisteration is ended")
        XCTAssertFalse(isEnableNoti, "Noti Resisteration is not end")
    }
    
    func testIsEnableCamera() {
        // Camera許可を切り替えてテスト
        
        let isEnableCamera = ApplicationManager.sharedInstance.isEnableCamera
        XCTAssertTrue(isEnableCamera, "Camera is not enabled")
//        XCTAssertFalse(isEnableCamera, "Camera is enabled")
    }
    
    func testRequestMicrophonePermission() {
        
        ApplicationManager.sharedInstance.requestMicrophonePermission({ (granted: Bool) in
            XCTAssertFalse(ApplicationManager.sharedInstance.isEnableMicrophone, "Microphone is not enabled")
            //XCTAssertTrue(ApplicationManager.sharedInstance.isEnableMicrophone, "Microphone is not enabled")
        })
    }
    
    func testRequestCameraPermission() {
        
        ApplicationManager.sharedInstance.requestCameraPermission({ (granted: Bool) in
            XCTAssertFalse(granted, "Microphone is not enabled")
            //XCTAssertTrue(granted, "Camera is not enabled")
        })
    }
    
    func testOpenAppStore() {
        
        ApplicationManager.sharedInstance.openAppStore()
        return
    }
    
    func testSetApplicationToOrientation() {
        
        ApplicationManager.sharedInstance.setPushNotification()
//        XCTAssertTrue(ApplicationManager.sharedInstance.isEnableNotification, "Noti Resisteration is ended")
        XCTAssertFalse(ApplicationManager.sharedInstance.isEnableNotification, "Noti Resisteration is not end")
        return
        
    }
    
    
}
