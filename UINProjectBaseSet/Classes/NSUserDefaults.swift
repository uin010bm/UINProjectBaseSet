//
//  NSUserDefaults.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation

public extension NSUserDefaults {
    
    
    // MARK: pubric functions
    /**
    Get UserDefaults value with string key.
    
    :param: key set key string
    
    :returns: nil or got object
    */
    public func pbs_objectForKey(key:String) -> AnyObject? {
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
    public func pbs_setObject<T:NSCoding>(obj:T, key:String) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(obj)
        self.setObject(data, forKey: key)
    }
}