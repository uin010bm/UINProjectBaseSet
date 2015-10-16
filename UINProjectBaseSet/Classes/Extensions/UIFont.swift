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
    /**
    Get HiraKakuProN-W3 font with size.
    
    :param: fontSize set font size
    
    :returns: HiraKakuProN-W3 UIFont
    */
    public class func hiraKakuProNW3(fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "HiraKakuProN-W3", size: fontSize)!
        return font
    }
    
    
    /**
    Get HiraKakuProN-W6 font with size.
    
    :param: fontSize set font size
    
    :returns: HiraKakuProN-W6 UIFont
    */
    public class func hiraKakuProNW6(fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "HiraKakuProN-W6", size: fontSize)!
        return font
    }
    
}