//
//  UITableView.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    // MARK: - public propertys
    /// if last cell showed in screen, return true
    public var isLastRowVisible: Bool {
        if let indexPath = (indexPathsForVisibleRows as [NSIndexPath]!).last {
            return indexPath.row == numberOfRowsInSection(0) - 1
        } else {
            return false
        }
    }
    
    
    
    // MARK: - public functions
    /**
    Set scroll position to bottom.
    
    :param: section  set last section number
    :param: animated set animation bool
    */
    public func scrollToBottom(section: Int = 0, animated: Bool = true) {
        let num = numberOfRowsInSection(section)
        if num > 0 {
            let indexPath = NSIndexPath(forRow: num - 1, inSection: section)
            scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: animated)
        }
    }
    
    
    /**
    Set scroll position to top.
    
    :param: section  set target section number
    :param: animated set animation bool
    */
    public func scrollToTop(section: Int = 0, animated: Bool = true) {
        let num = numberOfRowsInSection(section)
        if num > 0 {
            let indexPath = NSIndexPath(forRow: 0, inSection: section)
            scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: animated)
        }
    }
    
    
    /**
    Set nib to table.
    
    :param: type set cell class name from xib
    */
    public func registerNibFromClass<T: UITableViewCell>(type: T.Type) {
        let className = T.getClassNameWithoutNamespace()
        let nib = UINib(nibName: className, bundle: nil)
        registerNib(nib, forCellReuseIdentifier: className)
    }
    
    
    /**
    Set cell class to table.
    
    :param: type set cell class name
    */
    public func registerClassFromClass<T: UITableViewCell>(type: T.Type) {
        let className = T.getClassNameWithoutNamespace()
        registerClass(T.self, forCellReuseIdentifier: className)
    }
    
    
    /**
    Set reusable cell to table with indexpath and class or xib name.
    
    :param: type      set cell class or xib class
    :param: indexPath set indexPath
    
    :returns: dequeueReusableCell
    */
    public func dequeueReusableCell<T: UITableViewCell>(type: T.Type,
        forIndexPath indexPath: NSIndexPath) -> T {
            return dequeueReusableCellWithIdentifier(T.getClassNameWithoutNamespace(), forIndexPath: indexPath) as! T
    }
}