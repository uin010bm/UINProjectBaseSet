//
//  Function.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit


// MARK: - global functions

/// デバイスのiosVersionを取得する
///
///  - returns: version number
public func getiOSVersion() -> Double {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue
}


/// ビルドスキームに応じてLogを振り分ける
///
///  - parameter message:  ログメッセージ
///  - parameter function: 呼び出し元function (option)
///  - parameter file:     呼び出し元file (option)
///  - parameter line:     呼び出し元line (option)
public func Log(message: String,
    function: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__) {
        _ = [message,file,function,line]
        #if DEBUG
            print("Log \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
        #endif
}


///  アラートViewを表示する
///
///  - parameter title: アラートタイトルを設定
///  - parameter body:  アラートメッセージを設定
public func ALERT(title title:String, body: String) {
    #if DEBUG || STG
        UIAlertView(title: title, message: body, delegate: nil, cancelButtonTitle: "Close").show()
    #endif
}


///  blockをバックグラウンドキューで実行
///
///  - parameter closure: block構文
public func run_on_background_queue(closure: (() -> ())) {
    if !NSThread.isMainThread() {
        closure()
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            closure()
        })
    }
}


///  blockをメインキューで実行
///
///  - parameter closure: block構文
public func run_on_main_queue(closure:()->()) {
    if NSThread.isMainThread() {
        closure()
    } else {
        dispatch_async(dispatch_get_main_queue(), closure)
    }
}


///  blockを遅延実行
///
///  - parameter delay:   遅延時間をDoubleで指定
///  - parameter closure: block構文
public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}