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


/// For Management about Application setting
public class ApplicationManager: NSObject {
    
    // MARK: - singletone
    
    public class var sharedInstance : ApplicationManager {
        struct Static {
            static let instance : ApplicationManager = ApplicationManager()
        }
        return Static.instance
    }
    
    
    
    // MARK: - private propertys
    
    /// デバイスのマイク許可状態を取得
    ///
    ///  - returns: permission status.
    private func getMicrophonePermission() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeAudio)
    }
    
    
    /// デバイスのカメラ許可状態を取得
    ///
    /// - returns: permission status.
    private func getCameraPermission() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
    }
    
    
    
    // MARK: - public propertys
    
    /// アプリ向きがランドスケープであれば true を返す
    public var isLandscape: Bool { return UIApplication.sharedApplication().statusBarOrientation.isLandscape }
    
    /// アプリ向きがポートレートであれば true を返す
    public var isPortrait: Bool { return UIApplication.sharedApplication().statusBarOrientation.isPortrait }
    
    /// デバイスがPushNotificationをつかえれば true を返す
    public var isEnablePush: Bool {
        return (UIApplication.sharedApplication().currentUserNotificationSettings()!.types.intersect(UIUserNotificationType.Alert)) != []
    }
    
    /// デバイスがネットワークにコネクトできれば true を返す
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
    
    /// デバイスがネットワークにコネクトできれば true を返す
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
    
    /// デバイスがNotificationを利用可能であれば true を返す
    public var isEnableNotification: Bool {
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            let remoteNotificationType = UIApplication.sharedApplication().currentUserNotificationSettings()
            let isAuthorization = (remoteNotificationType != .None)
            
            return isAuthorization
        }
        
        return UIApplication.sharedApplication().isRegisteredForRemoteNotifications()
    }
    
    /// デバイスがカメラを利用可能であれば true を返す
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
    
    /// デバイスのマイク設定ダイアログを要求する
    ///
    ///  - parameter completion: 完了時ブロック構文。引数に許可状態の bool値 を渡す
    public func requestMicrophonePermission(completion: (granted: Bool) -> Void) {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeAudio, completionHandler: { (granted) -> Void in
            completion(granted: granted)
        })
    }
    
    
    /// デバイスのカメラ設定ダイアログを要求する
    ///
    ///  - parameter completion: 完了時ブロック構文。引数に許可状態の bool値 を渡す
    public func requestCameraPermission(completion: (granted: Bool) -> Void) {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granted) -> Void in
            completion(granted: granted)
        })
    }
    
    
    /// アプリストアを開く
    public func openAppStore() {
        if let appStoreURL = NSURL(string: "") {
            if UIApplication.sharedApplication().canOpenURL(appStoreURL) {
                UIApplication.sharedApplication().openURL(appStoreURL)
            }
        }
    }
    
    
    /// アプリ向きを指定の向きに変更する
    ///
    ///  - parameter orientation: アプリ向きを指定
    public func setApplicationToOrientation(orientation: UIInterfaceOrientation) {
        let value = orientation.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    
    /// PushNotificationに必要な初期設定を実行
    public func setPushNotification() {
        let application = UIApplication.sharedApplication()
        let settings: UIUserNotificationSettings = UIUserNotificationSettings( forTypes: [.Alert, .Badge, .Sound], categories: nil )
        application.registerUserNotificationSettings( settings)
        application.registerForRemoteNotifications()
    }
    
}