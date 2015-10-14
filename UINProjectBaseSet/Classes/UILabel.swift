//
//  UILabel.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit


extension UILabel {
    
    // MARK: - private functions
    /**
    Get NSParagraphStyle from self.
    
    :param: alignement    set NSTextAlignment
    :param: lineBreakMode set NSLineBreakMode
    
    :returns: NSParagraphStyle based self
    */
    private func getParagraphStyleWithLabelStyle(alignment: NSTextAlignment? = nil, lineBreakMode: NSLineBreakMode? = nil) -> NSParagraphStyle {
        let style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        style.alignment = alignment ?? self.textAlignment
        style.lineBreakMode = lineBreakMode ?? self.lineBreakMode
        return style
    }
    
    
    /**
    Get attribute setting array.
    
    :param: font           set UIFont
    :param: textColor      set text color
    :param: baselineOffset set offset
    :param: alignment      set NSTextAlignment
    :param: lineBreakMode  set NSLineBreakMode
    :param: lineHeight     set line height number by CGFloat
    
    :returns: attributes Array
    */
    private func getAttributeWithLabelStyle(font: UIFont? = nil, textColor: UIColor? = nil, baselineOffset: CGFloat? = nil, alignment: NSTextAlignment? = nil, lineBreakMode: NSLineBreakMode? = nil, lineHeight: CGFloat = 1.0) -> [String: AnyObject] {
        let attributes = [
            NSFontAttributeName: font ?? self.font!,
            NSForegroundColorAttributeName: textColor ?? self.textColor!,
            NSParagraphStyleAttributeName: self.getParagraphStyleWithLabelStyle(alignment, lineBreakMode: lineBreakMode),
            NSBaselineOffsetAttributeName: baselineOffset ?? 0,
            NSKernAttributeName: lineHeight
        ]
        return attributes
    }
    
    
    /**
    Set attributed text to Label.
    
    :param: string set string to text
    */
    private func setAttributedText(string string:String) {
        if 0 < string.characters.count {
            if let attributes = self.attributedText?.attributesAtIndex(0, effectiveRange:nil) {
                self.attributedText = NSAttributedString(string:string, attributes: attributes)
            }
        } else {
            self.attributedText = NSAttributedString(string:" ")
        }
    }

    
    
    // MARK: - public functions
    /**
    Set attribute settings to self.
    
    :param: text           set string to label text
    :param: font           set UIFont
    :param: textColor      set text color by UIColor
    :param: baselineOffset set baseline offset by CGFloat
    :param: alignment      set align direction by NSTextAlignment
    :param: lineBreakMode  set line break mode by NSLineBreakMode
    :param: lineHeight     set line height by CGFloat
    */
    public func setAttributedTextWithLabelStyle(text:String?, font:UIFont? = nil, textColor: UIColor? = nil, baselineOffset: CGFloat? = nil, alignment: NSTextAlignment? = nil, lineBreakMode: NSLineBreakMode? = nil, lineHeight: CGFloat = 1.0) {
        let attributes = self.getAttributeWithLabelStyle(font, textColor: textColor, baselineOffset: baselineOffset, alignment: alignment, lineBreakMode: lineBreakMode, lineHeight: lineHeight)
        self.attributedText =  NSAttributedString(string: text ?? "", attributes: attributes)
    }
}