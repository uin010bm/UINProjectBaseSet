//
//  UIImage.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import UIKit
import CoreGraphics
import UIImage_BlurredFrame


/// UIImageを拡張するためのExtension
/// UIImage_BlurredFrame をimport
public extension UIImage {
    
    // MARK: - public enum
    
    ///  グラデーションの開始位置を指定するためのenum type
    ///
    ///  - Top:         上部
    ///  - Bottom:      下部
    ///  - Right:       右
    ///  - Left:        左
    ///  - TopLeft:     左上
    ///  - TopRight:    右上
    ///  - BottomLeft:  左下
    ///  - BottomRight: 右下
    public enum GradationStart {
        case Top, Bottom, Right, Left, TopLeft, TopRight, BottomLeft, BottomRight
    }
    
    
    ///  リサイズする際の基準点を指定するためのenum type
    ///
    ///  - Center: 中央
    public enum ImageResizePosition {
        case Center
    }
    
    
    ///  ImageのAspectFit形式を指定するためのenum type
    ///
    ///  - ScaleToFill: 形状に併せて変化
    ///  - AspectFit:   最小値に基準を併せて変化
    ///  - AspectFill:  最大値に基準を併せて変化
    public enum ImageResizeAspect {
        case ScaleToFill
        case AspectFit
        case AspectFill
    }
    
    
    // MARK: - public class functions
    
    ///  グラデーション色を適用したImageを取得
    ///
    ///  - parameter size:           imageのサイズを指定
    ///  - parameter startPoint:     グラデーションの開始位置を指定
    ///  - parameter endPoint:       グラデーションの終了位置を指定
    ///  - parameter colors:         グラデーションする色配列を指定
    ///  - parameter givenLocations: 色変化の位置を指定
    ///
    ///  - returns: UIImage instance
    public class func getGradationImageWith(size size:CGSize, startPoint:CGPoint, endPoint:CGPoint, colors:[UIColor], locations givenLocations:[CGFloat]? = nil) -> UIImage {
        UIGraphicsBeginImageContext(size);
        
        if let context:CGContextRef = UIGraphicsGetCurrentContext(), colorspace:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB() {
            
            // components
            var components:[CGFloat] = []
            
            var r:CGFloat = 0.0
            var g:CGFloat = 0.0
            var b:CGFloat = 0.0
            var a:CGFloat = 0.0
            for (_, color) in colors.enumerate() {
                color.getRed(&r, green: &g, blue: &b, alpha: &a)
                components.append(r)
                components.append(g)
                components.append(b)
                components.append(a)
            }
            
            // locations
            var locations:[CGFloat] = []
            if givenLocations != nil {
                locations = givenLocations!
            } else {
                let delta:CGFloat = 1.0/CGFloat(colors.count - 1)
                var location:CGFloat = 0.0
                for (_, _) in colors.enumerate() {
                    locations.append(location)
                    location += delta
                }
            }
            
            if let gradient: CGGradientRef = CGGradientCreateWithColorComponents(colorspace, components, locations, Int(colors.count)) {
                CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, .DrawsBeforeStartLocation)
            }
            
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    ///  グラデーション色をenum type から指定して、適用したUIIamgeを取得する
    ///
    ///  - parameter size:      サイズ指定
    ///  - parameter startFrom: グラデーションのスタート位置をenum指定
    ///  - parameter colors:    グラデーションする色の配列を指定
    ///  - parameter locations: 色変化の位置を指定
    ///
    ///  - returns: UIImage instance
    public class func getGradationImageWith(size size:CGSize, startFrom:GradationStart, colors:[UIColor], locations:[CGFloat]? = nil) -> UIImage {
        var startPoint:CGPoint
        var endPoint:CGPoint
        let maxlength = max(size.width, size.height)
        let minlength = min(size.width, size.height)
        let adjust:CGFloat = (maxlength - minlength) * 0.25
        
        switch startFrom {
        case .Top:
            startPoint = CGPointMake(0, 0)
            endPoint = CGPointMake(0, size.height)
        case .Bottom:
            startPoint = CGPointMake(0, size.height)
            endPoint = CGPointMake(0, 0)
        case .Right:
            startPoint = CGPointMake(size.width, 0)
            endPoint = CGPointMake(0, 0)
        case .Left:
            startPoint = CGPointMake(0, 0)
            endPoint = CGPointMake(size.width, 0)
        case .TopLeft:
            if (size.width < size.height) {
                startPoint = CGPointMake(-adjust, adjust)
                endPoint   = CGPointMake(size.width + adjust, size.height - adjust)
            } else {
                startPoint = CGPointMake(adjust, -adjust)
                endPoint   = CGPointMake(size.width - adjust, size.height + adjust)
            }
        case .TopRight:
            startPoint = CGPointMake(size.width, 0)
            endPoint = CGPointMake(0, size.height)
        case .BottomLeft:
            startPoint = CGPointMake(0, size.height)
            endPoint = CGPointMake(size.width, 0)
        case .BottomRight:
            startPoint = CGPointMake(size.width, size.height)
            endPoint = CGPointMake(0, 0)
        }
        return self.getGradationImageWith(size: size, startPoint: startPoint, endPoint: endPoint, colors: colors, locations:locations)
    }
    
    
    ///  黒ベースのマスクグラデーションを適用したImageを取得する
    ///
    ///  - parameter size:      サイズを指定
    ///  - parameter startFrom: マスクグラデーションの開始位置をenum指定
    ///
    ///  - returns: UIImage instace
    public class func getGradationMaskedImageWith(size size:CGSize, startFrom:GradationStart) -> UIImage {
        let colors = [UIColor.blackColor(), UIColor.clearColor()]
        return self.getGradationImageWith(size: size, startFrom: startFrom, colors: colors)
    }
    
    
    ///  文字列を含んだImageコンテキストを取得する
    ///
    ///  - parameter text: 文字列を指定
    ///  - parameter size: imageのサイズを指定
    ///
    ///  - returns: UIImage instance
    public class func getImageWithText(text:NSString, size:CGSize) -> UIImage {
        let fontSize:CGFloat = 18.0
        UIGraphicsBeginImageContext(size)
        
        let style: NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        style.lineBreakMode = NSLineBreakMode.ByCharWrapping
        let attribures = [NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(fontSize),
            NSParagraphStyleAttributeName: style]
        
        text.drawInRect(CGRectMake(0,0, size.width, size.height), withAttributes: attribures)
        
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
    
    ///  ViewをベースにUIImageを取得する
    ///
    ///  - parameter view:   ベースとなるviewを指定
    ///  - parameter opaque: alphaを含めるか指定
    ///
    ///  - returns: UIIamge instance
    public class func getImageFromView(view:UIView, opaque:Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, opaque, 0)
        
        if let context = UIGraphicsGetCurrentContext() {
            CGContextTranslateCTM(context, -view.frame.origin.x, -view.frame.origin.y);
            view.layer.renderInContext(context)
        }
        
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return renderedImage;
    }
    
    
    
    // MARK: - private functions
    
    ///  中央を基準点にサイズを縮小したRectを取得
    ///
    ///  - parameter size: サイズ指定
    ///
    ///  - returns: CGRect instance
    private func getCenterRectForResize(size:CGSize) -> CGRect {
        let selfCenter = CGPointMake(self.size.width * 0.5, self.size.height * 0.5)
        let resizedCenter = CGPointMake(size.width * 0.5, size.height * 0.5)
        return CGRectMake(selfCenter.x - resizedCenter.x, selfCenter.y - resizedCenter.y, size.width, size.height)
    }
    
    
    
    // MARK: - public functions
    
    ///  リサイズしたimageを取得する
    ///
    ///  - parameter size:   サイズを指定
    ///  - parameter opaque: alphaを含めるか指定
    ///  - parameter aspect: AsoectFitの形式を指定
    ///
    ///  - returns: UIImage instance
    public func getResizedImageWith(size size:CGSize, opaque:Bool = true, aspect:ImageResizeAspect = .AspectFill) -> UIImage {
        // resize
        let scaledSize:CGSize
        switch aspect {
        case .ScaleToFill:
            scaledSize = size
        case .AspectFit: fallthrough
        case .AspectFill:
            let scale:CGFloat = self.getScaleWith(size, aspect:aspect)
            scaledSize = CGSizeMake(self.size.width * scale, self.size.height * scale)
        }
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, opaque, 0.0) // 0.0 uses device's scale factor
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetInterpolationQuality(context, .High)
        self.drawInRect(CGRectMake(0.0, 0.0, scaledSize.width, scaledSize.height))
        let resizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        // crop
        switch aspect {
        case .ScaleToFill:
            return resizedImage
        case .AspectFit:
            return resizedImage.getCroppedImageWith(size:scaledSize, position:.Center)
        case .AspectFill:
            return resizedImage.getCroppedImageWith(size:size, position:.Center)
        }
    }
    
    
    ///  Croppしたimageを取得する
    ///
    ///  - parameter size:     サイズ指定
    ///  - parameter position: 縮小の基準点をenum指定
    ///
    ///  - returns: UIImage instance
    public func getCroppedImageWith(size size:CGSize, position:ImageResizePosition = .Center) -> UIImage {
        let scale:CGFloat = UIScreen.mainScreen().scale
        let cropRect = self.getCenterRectForResize(CGSizeMake(size.width, size.height))
        let cropRectWithScaleFactor = CGRectMake(cropRect.origin.x * scale, cropRect.origin.y * scale, cropRect.size.width * scale, cropRect.size.height * scale)
        let cropRef = CGImageCreateWithImageInRect(self.CGImage, cropRectWithScaleFactor)
        let cropImage = UIImage(CGImage:cropRef!, scale:scale, orientation:UIImageOrientation.Up)
        return cropImage
    }
    

    ///  指定サイズとの比率を取得する
    ///
    ///  - parameter maxSize: 比較するサイズを指定
    ///  - parameter aspect:  AspectFit形式をenum指定
    ///
    ///  - returns: 結果として得られた比率
    public func getScaleWith(maxSize:CGSize, aspect:ImageResizeAspect = .AspectFit) -> CGFloat {
        switch aspect {
        case .ScaleToFill: fallthrough
        case .AspectFill:
            return max(maxSize.width/self.size.width, maxSize.height/self.size.height)
        case .AspectFit:
            return min(maxSize.width/self.size.width, maxSize.height/self.size.height)
        }
    }
    
    
    ///  ブラーをかけたimageを取得する
    ///
    ///  - returns: UIImage instance
    public func getBlurredImage() -> UIImage {
        return self.applyTintEffectWithColor(UIColor(white: 0.5, alpha: 1.0), atFrame: CGRectMake(0, 0, self.size.width, self.size.height))
    }
    
    
    ///  縦方向にブラーをかけたimageを取得する
    ///
    ///  - returns: UIIamge instance
    public func getBlurredImageVircialSide() -> UIImage {
        let topMask:UIImage = UIImage.getGradationMaskedImageWith(size: CGSizeMake(50, 50), startFrom: GradationStart.Top)
        var image = self
        image = self.applyBlurWithRadius(30, tintColor: UIColor.clearColor(), saturationDeltaFactor: 10.0, maskImage: topMask, atFrame: CGRectMake(0, 0, self.size.width, topMask.size.height))
        
        let bottomMask:UIImage = UIImage.getGradationMaskedImageWith(size: CGSizeMake(50, 50), startFrom: GradationStart.Bottom)
        image = image.applyBlurWithRadius(30, tintColor: UIColor.clearColor(), saturationDeltaFactor: 10.0, maskImage: bottomMask, atFrame: CGRectMake(0, self.size.height - bottomMask.size.height, self.size.width, bottomMask.size.height))
        
        return image
    }
    
    
    ///  縦方向にブラーをかけたimageをサイズ指定で取得する
    ///
    ///  - parameter size: サイズを指定
    ///
    ///  - returns: UIImage instance
    public func getVerticalBlurredImageWithSize(size size:CGSize) -> UIImage {
        let topMask:UIImage = UIImage.getGradationMaskedImageWith(size: size, startFrom: GradationStart.Top)
        var image = self
        image = self.applyBlurWithRadius(30, tintColor: UIColor.clearColor(), saturationDeltaFactor: 10.0, maskImage: topMask, atFrame: CGRectMake(0, 0, self.size.width, topMask.size.height))
        
        let bottomMask:UIImage = UIImage.getGradationMaskedImageWith(size: size, startFrom: GradationStart.Bottom)
        image = image.applyBlurWithRadius(30, tintColor: UIColor.clearColor(), saturationDeltaFactor: 10.0, maskImage: bottomMask, atFrame: CGRectMake(0, self.size.height - bottomMask.size.height, self.size.width, bottomMask.size.height))
        
        return image
    }

    
    ///  imageを縮小し、周りに50%の余暇を作成する
    ///
    ///  - returns: UIIamge instance
    public func getResizableImage() -> UIImage {
        let v = self.size.height * 0.5
        let p = self.size.width * 0.5
        return self.resizableImageWithCapInsets(UIEdgeInsets(top: v, left: p, bottom: v, right: p))
    }
    
}