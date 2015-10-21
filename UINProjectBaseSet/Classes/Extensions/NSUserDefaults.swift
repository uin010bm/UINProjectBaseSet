//
//  NSUserDefaults.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation


/// NSUserDefaultsを拡張するためのExtension
public extension NSUserDefaults {
    
    
    // MARK: - public functions
    
    ///  UserDefaultから指定KeyのObjectを取得
    ///
    ///  - parameter key: 取得したいObjのKeyを指定
    ///
    ///  - returns: 取得したObject または nil値
    public func getObjectForKey(key:String) -> AnyObject? {
        if let obj = self.objectForKey(key) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(obj)
        }
        return nil
    }
    
    
    /// UserDefaultにObjectを格納する
    ///
    ///  - parameter obj: 格納したいObjを指定
    ///  - parameter key: 格納先のKeyを指定
    public func setObjectWithKey<T:NSCoding>(obj:T, key:String) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(obj)
        self.setObject(data, forKey: key)
    }
}