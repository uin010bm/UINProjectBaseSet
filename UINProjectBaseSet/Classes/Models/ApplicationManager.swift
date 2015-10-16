//
//  ApplicationManager.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import UIKit
import SystemConfiguration
import AVFoundation


public class ApplicationManager : NSObject {
    
    // MARK: singletone
    /// singletone
    public class var sharedInstance : ApplicationManager {
        struct Static {
            static let instance : ApplicationManager = ApplicationManager()
        }
        return Static.instance
    }
    
    
    
    // MARK: - private propertys
    /**
    Check mic permission.
    
    :returns: permission status.
    */
    private func getMicrophonePermission() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeAudio)
    }
    
    
    /**
    Check camera permission.
    
    :returns: permission status.
    */
    private func getCameraPermission() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
    }
    
    
    
    // MARK: - public propertys
    /// if device orrientation is landscape, return true.
    public var isLandscape: Bool { return UIApplication.sharedApplication().statusBarOrientation.isLandscape }
    /// if device orrientation is portrait, return true.
    public var isPortrait: Bool { return UIApplication.sharedApplication().statusBarOrientation.isPortrait }
    /// if device can receive push, return true.
    public var isEnablePush: Bool {
        return (UIApplication.sharedApplication().currentUserNotificationSettings()!.types.intersect(UIUserNotificationType.Alert)) != []
    }
    /// if device can connect network, return true.
    public var isConnectedToNetwork: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    /// if device can access mic, return true.
    public var isEnableMicrophone: Bool {
        let status = self.getMicrophonePermission()
        
        if status == AVAuthorizationStatus.Authorized {
            // ok
            return true
        } else if status == AVAuthorizationStatus.Restricted {
            // the user have no permission
            return false
        } else if status == AVAuthorizationStatus.NotDetermined {
            // has not been determin use or not
            return false
        } else if status == AVAuthorizationStatus.Denied {
            // no permission
            return false
        }
        
        return false
    }
    /// if device can receive notification, return true.
    public var isEnableNotification: Bool {
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            let remoteNotificationType = UIApplication.sharedApplication().currentUserNotificationSettings()
            let isAuthorization = (remoteNotificationType != .None)
            
            return isAuthorization
        }
        
        return UIApplication.sharedApplication().isRegisteredForRemoteNotifications()
    }
    /// if device can access camera, return true.
    public var isEnableCamera: Bool {
        let status = self.getCameraPermission()
        
        if status == AVAuthorizationStatus.Authorized {
            // ok
            return true
        } else if status == AVAuthorizationStatus.Restricted {
            // the user have no permission
            return false
        } else if status == AVAuthorizationStatus.NotDetermined {
            // has not been determin use or not
            return false
        } else if status == AVAuthorizationStatus.Denied {
            // no permission
            return false
        }
        
        return false
    }
    
    
    
    // MARK: public functions
    /**
    Show dialog about device's mic setting.
    
    :param: completion set block. if mic setting is enabled, return true param.
    */
    public func requestMicrophonePermission(completion: (granted: Bool) -> Void) {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeAudio, completionHandler: { (granted) -> Void in
            completion(granted: granted)
        })
    }
    
    
    /**
    Show dialog about device's camera setting.
    
    :param: completion set block. if camera setting is enabled, return true param.
    */
    public func requestCameraPermission(completion: (granted: Bool) -> Void) {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granted) -> Void in
            completion(granted: granted)
        })
    }
    
    
    /**
    Open itunes install page.
    */
    public func openAppStore() {
        if let appStoreURL = NSURL(string: "") {
            if UIApplication.sharedApplication().canOpenURL(appStoreURL) {
                UIApplication.sharedApplication().openURL(appStoreURL)
            }
        }
    }
    
    
    /**
    Set app orientation to landscapeLeft
    */
    public func setApplicationToOrientation(orientation: UIInterfaceOrientation) {
        let value = orientation.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    
    public func setPushNotification() {
        let application = UIApplication.sharedApplication()
        let settings: UIUserNotificationSettings = UIUserNotificationSettings( forTypes: [.Alert, .Badge, .Sound], categories: nil )
        application.registerUserNotificationSettings( settings)
        application.registerForRemoteNotifications()
    }
    
}