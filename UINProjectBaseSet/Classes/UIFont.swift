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
    Get mgenplus-1c-regular font with size.
    
    :param: fontSize set font size
    
    :returns: mgenplus-1c-regular UIFont
    */
    public class func mgenplus1cRegular(fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "mgenplus-1c-regular", size: fontSize) {
            return font
        }
        return systemFontOfSize(fontSize)
    }
    
    
    /**
    Get mgenplus-1c-bold font with size.
    
    :param: fontSize set font size
    
    :returns: mgenplus-1c-bold UIFont
    */
    public class func mgenplus1cBold(fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "mgenplus-1c-bold", size: fontSize) {
            return font
        }
        return systemFontOfSize(fontSize)
    }
    
    
    /**
    Get LetsgoDigital-Regular font with size.
    
    :param: fontSize set font size
    
    :returns: LetsgoDigital-Regular UIFont
    */
    public class func letsgoDigital(fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "LetsgoDigital-Regular", size: fontSize) {
            return font
        }
        return systemFontOfSize(fontSize)
    }
    
    
    /**
    Get HiraKakuProN-W3 font with size.
    
    :param: fontSize set font size
    
    :returns: HiraKakuProN-W3 UIFont
    */
    public class func hiraKakuProNW3(fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HiraKakuProN-W3", size: fontSize) {
            return font
        }
        return systemFontOfSize(fontSize)
    }
    
    
    /**
    Get HiraKakuProN-W6 font with size.
    
    :param: fontSize set font size
    
    :returns: HiraKakuProN-W6 UIFont
    */
    public class func hiraKakuProNW6(fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HiraKakuProN-W6", size: fontSize) {
            return font
        }
        return systemFontOfSize(fontSize)
    }
    
}