//
//  NSUserDefaults.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation

public extension NSUserDefaults {
    
    
    // MARK: - public functions
    /**
    Get UserDefaults value with string key.
    
    :param: key set key string
    
    :returns: nil or got object
    */
    public func getObjectForKey(key:String) -> AnyObject? {
        if let obj = self.objectForKey(key) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(obj)
        }
        return nil
    }
    
    
    /**
    Set UserDefaults value with string key.
    
    :param: obj set object to leave
    :param: key set key string
    */
    public func setObjectWithKey<T:NSCoding>(obj:T, key:String) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(obj)
        self.setObject(data, forKey: key)
    }
}