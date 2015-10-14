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

public enum GradationStart {
    case Top, Bottom, Right, Left, TopLeft, TopRight, BottomLeft, BottomRight
}

public enum ImageResizePosition {
    case Center
}

public enum ImageResizeAspect {
    case ScaleToFill
    case AspectFit
    case AspectFill
}

public extension UIImage {
    
    // MARK: static functions
    /**
    Get gradient context image.
    
    :param: size           set image size
    :param: startPoint     set gradient start point
    :param: endPoint       set gradient end point
    :param: colors         set gradient colors by Array
    :param: givenLocations set gradient location ratio by CGFloat
    
    :returns: gradiate context UIIamge
    */
    public class func pbs_gradationImage(size size:CGSize, startPoint:CGPoint, endPoint:CGPoint, colors:[UIColor], locations givenLocations:[CGFloat]? = nil) -> UIImage {
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
    
    
    /**
    Get gradient image with start enum.
    
    :param: size      set image size
    :param: startFrom set GradationStart enum
    :param: colors    set colors by Array
    :param: locations locations
    
    :returns: gradiation context UIImage
    */
    public class func pbs_gradationImage(size size:CGSize, startFrom:GradationStart, colors:[UIColor], locations:[CGFloat]? = nil) -> UIImage {
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
            // TODO: implement other types
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
        return self.pbs_gradationImage(size: size, startPoint: startPoint, endPoint: endPoint, colors: colors, locations:locations)
    }
    
    
    /**
    Get dark mask gradient context image.
    
    :param: size      set image size
    :param: startFrom set GradationStart enum
    
    :returns: masked UIImage
    */
    public class func pbs_gradationMask(size size:CGSize, startFrom:GradationStart) -> UIImage {
        let colors = [UIColor.blackColor(), UIColor.clearColor()]
        return self.pbs_gradationImage(size: size, startFrom: startFrom, colors: colors)
    }
    
    
    /**
    Get image context included text.
    
    :param: text set insert text
    :param: size set text rect
    
    :returns: incleded text UIImage
    */
    public class func pbs_imageWithText(text:NSString, size:CGSize) -> UIImage {
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
    
    
    /**
    Get image context from view.
    
    :param: view set base UIView
    :param: opaque set opaque Bool
    
    :returns: UIImage based view
    */
    public class func pbs_imageFromView(view:UIView, opaque:Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, opaque, 0)
        
        if let context = UIGraphicsGetCurrentContext() {
            CGContextTranslateCTM(context, -view.frame.origin.x, -view.frame.origin.y);
            view.layer.renderInContext(context)
        }
        
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return renderedImage;
    }
    
    
    
    // MARK: private functions
    /**
    Get center rect for resizing.
    
    :param: size set resize rect
    
    :returns: center CGRect
    */
    private func centerRectForResized(size:CGSize) -> CGRect {
        let selfCenter = CGPointMake(self.size.width * 0.5, self.size.height * 0.5)
        let resizedCenter = CGPointMake(size.width * 0.5, size.height * 0.5)
        return CGRectMake(selfCenter.x - resizedCenter.x, selfCenter.y - resizedCenter.y, size.width, size.height)
    }
    
    
    
    // MARK: public functions
    /**
    Get resized Image.
    
    :param: size   set convert size
    :param: opaque set opaque enable
    :param: aspect set ImageResizeAspect enum
    
    :returns: resized UIImage
    */
    public func resizedImage(size size:CGSize, opaque:Bool = true, aspect:ImageResizeAspect = .AspectFill) -> UIImage {
        // resize
        let scaledSize:CGSize
        switch aspect {
        case .ScaleToFill:
            scaledSize = size
        case .AspectFit: fallthrough
        case .AspectFill:
            let scale:CGFloat = self.scaleForSize(size, aspect:aspect)
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
            return resizedImage.croppedImage(size:scaledSize, position:.Center)
        case .AspectFill:
            return resizedImage.croppedImage(size:size, position:.Center)
        }
    }
    
    
    /**
    Get cropped Image.
    
    :param: size     set cropping size
    :param: position set ImageResizePosition enum
    
    :returns: cropped UIImage
    */
    public func croppedImage(size size:CGSize, position:ImageResizePosition = .Center) -> UIImage {
        let scale:CGFloat = UIScreen.mainScreen().scale
        let cropRect = self.centerRectForResized(CGSizeMake(size.width, size.height))
        let cropRectWithScaleFactor = CGRectMake(cropRect.origin.x * scale, cropRect.origin.y * scale, cropRect.size.width * scale, cropRect.size.height * scale)
        let cropRef = CGImageCreateWithImageInRect(self.CGImage, cropRectWithScaleFactor)
        let cropImage = UIImage(CGImage:cropRef!, scale:scale, orientation:UIImageOrientation.Up)
        return cropImage
    }
    

    /**
    Get scale from max size and self size.
    
    :param: maxSize set scaling max size
    :param: aspect  set ImageResizeAspect enum.
    
    :returns: scale num by CGFloat
    */
    public func scaleForSize(maxSize:CGSize, aspect:ImageResizeAspect = .AspectFit) -> CGFloat {
        switch aspect {
        case .ScaleToFill: fallthrough
        case .AspectFill:
            return max(maxSize.width/self.size.width, maxSize.height/self.size.height)
        case .AspectFit:
            return min(maxSize.width/self.size.width, maxSize.height/self.size.height)
        }
    }
    
    
    /**
    Get blured image.
    
    :returns: blured UIImage
    */
    public func pbs_blurredImage() -> UIImage {
        return self.applyTintEffectWithColor(UIColor(white: 0.5, alpha: 1.0), atFrame: CGRectMake(0, 0, self.size.width, self.size.height))
    }
    
    
    /**
    Get blured image gradient vertical.
    
    :returns: blured UIImage
    */
    public func pbs_blurredImageVircialSide() -> UIImage {
        let topMask:UIImage = UIImage.pbs_gradationMask(size: CGSizeMake(50, 50), startFrom: GradationStart.Top)
        var image = self
        image = self.applyBlurWithRadius(30, tintColor: UIColor.clearColor(), saturationDeltaFactor: 10.0, maskImage: topMask, atFrame: CGRectMake(0, 0, self.size.width, topMask.size.height))
        
        let bottomMask:UIImage = UIImage.pbs_gradationMask(size: CGSizeMake(50, 50), startFrom: GradationStart.Bottom)
        image = image.applyBlurWithRadius(30, tintColor: UIColor.clearColor(), saturationDeltaFactor: 10.0, maskImage: bottomMask, atFrame: CGRectMake(0, self.size.height - bottomMask.size.height, self.size.width, bottomMask.size.height))
        
        return image
    }
    
    
    /**
    Get blured image gradient vertical with height size.
    
    :param: size set height size to set vertical blur
    
    :returns: blured UIImage
    */
    public func pbs_blurredImageVircialSide(size size:CGSize) -> UIImage {
        let topMask:UIImage = UIImage.pbs_gradationMask(size: size, startFrom: GradationStart.Top)
        var image = self
        image = self.applyBlurWithRadius(30, tintColor: UIColor.clearColor(), saturationDeltaFactor: 10.0, maskImage: topMask, atFrame: CGRectMake(0, 0, self.size.width, topMask.size.height))
        
        let bottomMask:UIImage = UIImage.pbs_gradationMask(size: size, startFrom: GradationStart.Bottom)
        image = image.applyBlurWithRadius(30, tintColor: UIColor.clearColor(), saturationDeltaFactor: 10.0, maskImage: bottomMask, atFrame: CGRectMake(0, self.size.height - bottomMask.size.height, self.size.width, bottomMask.size.height))
        
        return image
    }

    
    /**
    Get resizable image.
    
    :returns: resizable UIImage
    */
    public func pbs_resizableImage() -> UIImage {
        let v = self.size.height * 0.5
        let p = self.size.width * 0.5
        return self.resizableImageWithCapInsets(UIEdgeInsets(top: v, left: p, bottom: v, right: p))
    }
    
}