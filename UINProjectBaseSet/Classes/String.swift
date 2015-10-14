//
//  String.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    // MARK: - static functions
    /**
    Check string to use password.
    
    :param: password set password
    
    :returns: if string can use to password, return true
    */
    static func checkValidPassword(password: String?) -> Bool {
        let PasswordValidLength = 6
        return (password != nil && (password!).characters.count >= PasswordValidLength) ? true:false
    }
    
    
    /**
    Check string to use email address.
    
    :param: email set email address
    
    :returns: if string can use to password, return true
    */
    static func checkValidEmail(email:String) -> Bool {
        let PBRegEXPattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$"
        let regEx: NSRegularExpression?
        do {
            regEx = try NSRegularExpression(pattern:PBRegEXPattern,
                options: NSRegularExpressionOptions.CaseInsensitive)
        } catch _ {
            regEx = nil
        }
        let regExMatches = regEx?.numberOfMatchesInString(email,
            options: NSMatchingOptions.ReportProgress,
            range: NSMakeRange(0,email.characters.count))
        return (regExMatches == 0) ? false : true
    }
    
    
    
    // MARK: - public functions
    /**
    Get encoded string for url.
    
    :returns: encoded url string
    */
    public func convertUrlEncoded() -> String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLUserAllowedCharacterSet())!
    }
    
    
    /**
    Get decoded string for url.
    
    :returns: decoded url string
    */
    public func convertUrlDecoded() -> String {
        return self.stringByRemovingPercentEncoding!
    }
    
    
    /**
    Get beginning string with index.
    
    :param: endIndex set target index to get beginning string.
    
    :returns: beginning string.
    */
    public func getSubstringToIndex(endIndex:Int) -> String {
        if self.characters.count < endIndex {
            return self
        }
        return self.substringToIndex(self.startIndex.advancedBy(endIndex))
    }
    
    
    /**
    Get rect size adjusted with font and attributes.
    
    :param: font          set UIFont
    :param: lineBreakMode set NSLineBreakMode
    :param: lineHeight    set line height num
    :param: size          set CGSize (should set witdh or height to max)
    
    :returns: adjusted rect size
    */
    public func getSize(font:UIFont, lineBreakMode:NSLineBreakMode, lineHeight:CGFloat = 1.0, constrainedToSize size:CGSize) -> CGSize {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = lineBreakMode
        style.lineSpacing = (lineHeight - 1.0) * font.pointSize
        
        let titleAttr = [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: style
        ]
        
        let rect = (self as NSString).boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: titleAttr, context: NSStringDrawingContext())
        return rect.size
    }
    
    
    /**
    Convert string end to ellipsis.
    
    :param: count set show string count
    
    :returns: string with ellipsis
    */
    public func getConvertEndToEllipsisAtCount(count: Int) -> String {
        if self.characters.count > count {
            return self.getSubstringToIndex(count) + "..."
        }
        return self
    }
    
    
    /**
    Get string appended string for file path.
    
    :param: path set path string
    
    :returns: file path string
    */
    public func getPathAppendedComponentWithPath(path: String) -> String {
        return (self as NSString).stringByAppendingPathComponent(path)
    }
}