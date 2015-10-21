//
//  NSObject.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation


/// NSObjectを拡張するためのExtension
public extension NSObject {
    
    // MARK: - public class functions
    
    /// ClassNameをClassから取得する
    ///
    ///  - returns: Class名String
    public class func getClassNameWithoutNamespace() -> String {
        let fullClassName = NSStringFromClass(self)
        if let range = fullClassName.rangeOfString(".") {
            return fullClassName.substringFromIndex(range.endIndex)
        } else {
            return fullClassName
        }
    }
    
    
    // MARK: - public functions
    
    /// ClassNameをインスタンスから取得する
    ///
    ///  - returns: Class名String
    public func getClassNameWithoutNamespace() -> String {
        let fullClassName = NSStringFromClass(self.classForCoder)
        if let range = fullClassName.rangeOfString(".") {
            return fullClassName.substringFromIndex(range.endIndex)
        } else {
            return fullClassName
        }
    }
}