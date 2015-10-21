//
//  UIFont.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    // MARK: - public class functions

    ///  HiraKakuProN-W3 フォントを取得する
    ///
    ///  - parameter fontSize: フォントサイズの指定
    ///
    ///  - returns: UIFont instance
    public class func getHiraKakuProNW3(fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "HiraKakuProN-W3", size: fontSize)!
        return font
    }
    
    
    ///  HiraKakuProN-W6 フォントを取得する
    ///
    ///  - parameter fontSize: フォントサイズの指定
    ///
    ///  - returns: UIFont instance
    public class func getHiraKakuProNW6(fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "HiraKakuProN-W6", size: fontSize)!
        return font
    }
    
}