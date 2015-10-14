//
//  Function.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit


// MARK: global functions
/**
Get device ios version.

:returns: version numver
*/
public func getiOSVersion() -> Double {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue
}


/**
Print log when build scheme is debug.

:param: message  log message
:param: function arrived function
:param: file     arrived file
:param: line     line number
*/
public func Log(message: String,
    function: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__) {
        _ = [message,file,function,line]
        #if DEBUG || STG
            print("Log \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
        #endif
}


/**
Pop Alert View.

:param: title set title string
:param: body  set body message
*/
public func ALERT(title title:String, body: String) {
    #if DEBUG || STG
        UIAlertView(title: title, message: body, delegate: nil, cancelButtonTitle: "Close").show()
    #endif
}


/**
Start closure in background queue.

:param: closure set block
*/
public func run_on_background_queue(closure: (() -> ())) {
    if !NSThread.isMainThread() {
        closure()
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            closure()
        })
    }
}


/**
Start closure in main queue.

:param: closure set block
*/
public func run_on_main_queue(closure:()->()) {
    if NSThread.isMainThread() {
        closure()
    } else {
        dispatch_async(dispatch_get_main_queue(), closure)
    }
}


/**
Start closure after ended timer.

:param: delay   set delay time
:param: closure set block
*/
public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}