//
//  String.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit


/// Stringを拡張するためのExtension
public extension String {
    
    
    // MARK: - static functions
    
    ///  パスワードに設定可能か判定する
    ///
    ///  - parameter password: パスワード文字列を指定
    ///
    ///  - returns: 判定結果を返却
    public static func checkValidPassword(password: String?) -> Bool {
        let PasswordValidLength = 6
        return (password != nil && (password!).characters.count >= PasswordValidLength) ? true:false
    }
    
    
    /// emailアドレスとして利用可能か判定する
    ///
    ///  - parameter email: emailアドレスを指定
    ///
    ///  - returns: 判定結果を返却
    public static func checkValidEmail(email:String) -> Bool {
        let PBRegEXPattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$"
        let regEx = try! NSRegularExpression(pattern:PBRegEXPattern,
                options: NSRegularExpressionOptions.CaseInsensitive)
        let regExMatches = regEx.numberOfMatchesInString(email,
            options: NSMatchingOptions.ReportProgress,
            range: NSMakeRange(0,email.characters.count))
        return (regExMatches == 0) ? false : true
    }
    
    
    
    // MARK: - public functions
    
    ///  URLをエンコードする
    ///
    ///  - returns: エンコード済みURL
    public func convertUrlEncoded() -> String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLUserAllowedCharacterSet())!
    }
    
    
    ///  URLをデコードする
    ///
    ///  - returns: デコード済みURL
    public func convertUrlDecoded() -> String {
        return self.stringByRemovingPercentEncoding!
    }
    
    
    ///  文字列の冒頭を取得する
    ///
    ///  - parameter endIndex: 最後尾文字列のindexを指定
    ///
    ///  - returns: 生成した文字列を返却
    public func getSubstringToIndex(endIndex:Int) -> String {
        if self.characters.count < endIndex {
            return self
        }
        return self.substringToIndex(self.startIndex.advancedBy(endIndex))
    }
    
    
    ///  文字列を指定条件に当て込んだ際の高さを取得する
    ///
    ///  - parameter font:          フォント情報を指定
    ///  - parameter lineBreakMode: 折り返しを指定
    ///  - parameter lineHeight:    lineHeight値を指定
    ///  - parameter size:          想定するRectを指定
    ///
    ///  - returns: 計算結果を返却
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
    
    
    ///  文字列の末尾をEllipsisに変更する
    ///
    ///  - parameter count: 表示する文字数を指定
    ///
    ///  - returns: 変換後の文字列を返却
    public func getConvertEndToEllipsisAtCount(count: Int) -> String {
        if self.characters.count > count {
            return self.getSubstringToIndex(count) + "..."
        }
        return self
    }
    
    
    ///  DirectoryPathを想定した文字列に、DirectoryPathをStringで追加する
    ///
    ///  - parameter path: 追加したいDirectory文字列
    ///
    ///  - returns: 結合後のDirectoryPath文字列を返却
    public func getPathAppendedComponentWithPath(path: String) -> String {
        return (self as NSString).stringByAppendingPathComponent(path)
    }
    
}