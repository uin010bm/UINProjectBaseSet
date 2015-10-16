//
//  UIColor.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import UIKit


public extension UIColor {
    
    // MARK: - public enum
    /**
    Enumulation to application color type.
    */
    public enum ColorType: String {
        case Navigation = "#050505"
        case Black = "#000000"
        case White = "#FFFFFF"
        case LightGray = "#F6F6F6"
        case Caution = "#e40b26"
        case Border = "#898989"
    }
    
    
    
    // MARK: - convenience init
    /**
    Init with application colorType.
    
    :param: colorType set colorType enum
    */
    public convenience init(colorType: ColorType) {
        self.init(rgba: colorType.rawValue)
    }
    
    
    /**
    Init with rgba string.
    
    :param: rgba set rgba string with # on begining
    */
    public convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.startIndex.advancedBy(1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch hex.characters.count {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    
    
    // MARK: - public functions
    /**
    Get colord context image.
    
    :returns: empty image.
    */
    public func getColoredImage() -> UIImage {
        return self.getColoredImageWithSize(CGSizeMake(1, 1))
    }
    
    
    /**
    Get colored context image.
    
    :param: size set images CGSize
    
    :returns: colored context image
    */
    public func getColoredImageWithSize(size:CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size)
        if let context:CGContextRef = UIGraphicsGetCurrentContext() {
            CGContextSetFillColorWithColor(context, self.CGColor)
            CGContextFillRect(context, rect)
        }
        
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    
    /**
    Get more dark color.
    
    :returns: darken UIColor
    */
    public func getDarkenColor() -> UIColor {
        return self.getDarkenColorWithRatio(0.6)
    }
    
    
    /**
    Get more dark color with ratio.
    
    :param: ratio set ratio num by CGFloat
    
    :returns: darken UIColor
    */
    public func getDarkenColorWithRatio(ratio:CGFloat) -> UIColor {
        var hue:CGFloat  = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        
        let _ = self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: (brightness * ratio), alpha: alpha)
    }

}