//
//  NSObject.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation

public extension NSObject {
    
    // MARK: static functions
    /// Get class name from classObject.
    public class func classNameWithoutNamespace() -> String {
        let fullClassName = NSStringFromClass(self)
        let range = fullClassName.rangeOfString(".")
        return fullClassName.substringFromIndex(range!.endIndex)
    }
    
    
    // MARK: pubric functions
    /**
    Get class name from instance.
    
    :returns: class name string
    */
    public func classNameWithoutNamespace() -> String {
        let fullClassName = NSStringFromClass(self.classForCoder)
        let range = fullClassName.rangeOfString(".")
        return fullClassName.substringFromIndex(range!.endIndex)
    }
}