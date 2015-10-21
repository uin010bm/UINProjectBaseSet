//
//  UITableView.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit


/// UITableViewを拡張するためのExtension
extension UITableView {
    
    // MARK: - public propertys
    
    /// 最後のcellが表示されていれば true
    public var isLastRowVisible: Bool {
        if let paths = indexPathsForVisibleRows as [NSIndexPath]! {
            if let indexPath = paths.last {
                return indexPath.row == numberOfRowsInSection(0) - 1
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    
    
    // MARK: - public functions
    
    ///  最下部へスクロール
    ///
    ///  - parameter section:  最下部のセクションを指定
    ///  - parameter animated: アニメーションスクロールにするか
    public func scrollToBottom(section: Int = 0, animated: Bool = true) {
        let num = numberOfRowsInSection(section)
        if num > 0 {
            let indexPath = NSIndexPath(forRow: num - 1, inSection: section)
            scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: animated)
        }
    }
    
    
    ///  最上部へスクロール
    ///
    ///  - parameter section:  最上部のセクションを指定 (optional)
    ///  - parameter animated: アニメーションスクロールにするか
    public func scrollToTop(section: Int = 0, animated: Bool = true) {
        let num = numberOfRowsInSection(section)
        if num > 0 {
            let indexPath = NSIndexPath(forRow: 0, inSection: section)
            scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: animated)
        }
    }
    
    
    ///  CellをNibClassから設定する
    ///
    ///  - parameter type: CellClassを指定
    public func registerNibFromClass<T: UITableViewCell>(type: T.Type) {
        let className = T.getClassNameWithoutNamespace()
        let nib = UINib(nibName: className, bundle: nil)
        registerNib(nib, forCellReuseIdentifier: className)
    }
    
    
    ///  CellをClassから設定する
    ///
    ///  - parameter type: CellClassを指定
    public func registerCellClassFromClass<T: UITableViewCell>(type: T.Type) {
        let className = T.getClassNameWithoutNamespace()
        registerClass(T.self, forCellReuseIdentifier: className)
    }
    
    
    ///  再利用可能なCellを登録する
    ///
    ///  - parameter type:      CellClassを指定
    ///  - parameter indexPath: cellのindexを指定
    ///
    ///  - returns: Cell instance
    public func dequeueReusableCell<T: UITableViewCell>(type: T.Type,
        forIndexPath indexPath: NSIndexPath) -> T {
            return dequeueReusableCellWithIdentifier(T.getClassNameWithoutNamespace(), forIndexPath: indexPath) as! T
    }
}