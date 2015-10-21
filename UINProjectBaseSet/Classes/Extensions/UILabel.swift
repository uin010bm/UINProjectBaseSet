//
//  UILabel.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit


/// UILabelを拡張するためのExtension
extension UILabel {
    
    // MARK: - private functions
    
    ///  指定したAttributeもしくは現状のLabelからNSParagraphStyleを取得する
    ///
    ///  - parameter alignment:     textAlignmentを指定
    ///  - parameter lineBreakMode: 改行モードを指定
    ///
    ///  - returns: NSParagraphStyleを返却
    private func getParagraphStyleWithLabelStyle(alignment: NSTextAlignment? = nil, lineBreakMode: NSLineBreakMode? = nil) -> NSParagraphStyle {
        let style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        style.alignment = alignment ?? self.textAlignment
        style.lineBreakMode = lineBreakMode ?? self.lineBreakMode
        return style
    }
    
    
    ///  Labelの設定に必要な設定値を含んだDictionaryを取得
    ///
    ///  - parameter font:           Font情報を設定
    ///  - parameter textColor:      textカラーを設定
    ///  - parameter baselineOffset: 行のoffsetを設定
    ///  - parameter alignment:      行揃えを指定
    ///  - parameter lineBreakMode:  改行を指定
    ///  - parameter lineHeight:     行の高さを指定
    ///
    ///  - returns: 設定値を含むDictionaty (for NSAttributedString)
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
    
    
    // MARK: - public functions
    
    ///  引数からLabelStyleを適用する
    ///
    ///  - parameter text:           文言を指定
    ///  - parameter font:           フォントを指定
    ///  - parameter textColor:      textカラーを指定
    ///  - parameter baselineOffset: 行のoffsetを指定
    ///  - parameter alignment:      行揃えを指定
    ///  - parameter lineBreakMode:  改行を指定
    ///  - parameter lineHeight:     行の高さを指定
    public func setAttributedTextWithLabelStyle(text:String?, font:UIFont? = nil, textColor: UIColor? = nil, baselineOffset: CGFloat? = nil, alignment: NSTextAlignment? = nil, lineBreakMode: NSLineBreakMode? = nil, lineHeight: CGFloat = 1.0) {
        let attributes = self.getAttributeWithLabelStyle(font, textColor: textColor, baselineOffset: baselineOffset, alignment: alignment, lineBreakMode: lineBreakMode, lineHeight: lineHeight)
        self.attributedText =  NSAttributedString(string: text ?? "", attributes: attributes)
    }
}