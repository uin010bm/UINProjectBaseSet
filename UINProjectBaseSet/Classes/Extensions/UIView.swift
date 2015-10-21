//
//  UIView.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit


/// UIViewを拡張するためのExtension
extension UIView {
    
    
    // MARK: - public enum
    
    ///  Viewの形状変化のためのenum type
    ///
    ///  - Circle:        円形
    ///  - RoundedCorner: 角丸
    public enum ViewShape {
        case Circle, RoundedCorner
    }
    
    ///  Viewにフィルタを指定するためのenum type
    ///
    ///  - DarkEdgeVirtical: 縦方向の黒グラデーション
    ///  - BlurredVirtical: 縦方向のブラー
    public enum ViewFilter : Int {
        case DarkEdgeVirtical = 1
        case BlurredVirtical  = 2
    }
    
    ///  Viewにドロップシャドウを指定するための enum type
    ///
    ///  - Rect:    Viewと同様のRectを投影する(radius対応)
    ///  - Circle:  丸い形状を投影
    ///  - Dynamic: そのまま投影
    public enum DropShadowType {
        case Rect, Circle, Dynamic
    }

    
    
    // MARK: - public struct
    
    /// ボーダーを指定するためのBit演算struct
    public struct BorderPositions : OptionSetType {
        
        init(_ value: UInt) { self.value = value }
        init(nilLiteral: ()) { self.value = 0 }
        public init(rawValue value: UInt) { self.value = value }
        
        static var allZeros: BorderPositions { return self.init(0) }
        static var Top: BorderPositions   { return self.init(1 << 0) }
        static var Left: BorderPositions  { return self.init(1 << 1) }
        static var Bottom: BorderPositions   { return self.init(1 << 2) }
        static var Right: BorderPositions   { return self.init(1 << 3) }
        
        private var value: UInt = 0
        
        public var rawValue: UInt { return self.value }
        
        static func fromMask(raw: UInt) -> BorderPositions { return self.init(raw) }
    }
    
    
    
    // MARK: - public class functions
    
    ///  Float指定によるstart/end/current値から現在の進捗比率を返却
    ///
    ///  - parameter start:         start値を設定
    ///  - parameter end:           end値を設定
    ///  - parameter current:       現在値を設定
    ///  - parameter allowOverflow: end値以上を許容するか
    ///
    ///  - returns: 現在の進捗比率
    public class func getProgress(start start:CGFloat, end:CGFloat, current:CGFloat, allowOverflow:Bool = true) -> CGFloat {
        var progress:CGFloat = (current - start) / (end - start)
        if !allowOverflow {
            progress = max(min(progress, 1.0), 0.0)
        }
        return progress
    }
    
    
    ///  Float指定によるstart/end値と現在の進捗比率から、現在値を計算して返却
    ///
    ///  - parameter start:    start値
    ///  - parameter end:      end値
    ///  - parameter progress: 現在の進捗比率
    ///
    ///  - returns: 現在値
    public class func getProgressValue(start start:CGFloat, end:CGFloat, progress:CGFloat) -> CGFloat {
        return (end - start) * progress + start
    }
    
    
    
    
    // MARK: - public functions
    
    ///  selfViewからシャドウViewを作成し、返却する
    ///
    ///  - returns: シャドウView
    public func getInnerShadow() -> UIImageView {
        let shadow = UIImage.getGradationImageWith(size: CGSizeMake(1.0, self.frame.size.height * 0.5), startFrom: UIImage.GradationStart.Bottom, colors: [UIColor(white: 0.0, alpha: 0.5), UIColor(white:0.0, alpha:0.0)])
        let shadowView = UIImageView(image: shadow)
        shadowView.userInteractionEnabled = false
        shadowView.frame.size.width = self.frame.size.width
        shadowView.frame.origin.y = self.frame.size.height * 0.5
        shadowView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin]
        return shadowView
    }

    
    ///  Viewの形状を変化させる
    ///
    ///  - parameter shape: 形状をenum指定
    public func convertShape(shape:ViewShape) {
        switch shape {
        case .Circle:
            self.layer.cornerRadius = self.frame.size.width * 0.5
            self.clipsToBounds = true
        case .RoundedCorner:
            self.layer.cornerRadius = 10.0
            self.layer.borderWidth = 0.0
            self.clipsToBounds = true
        }
    }
    
    
    ///  viewからimageコンテキストを取得
    ///
    ///  - returns: UIImage instance
    public func getImageContextFromView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.mainScreen().scale)
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    ///  Viewにボーダーを追加する
    ///
    ///  - parameter position: ボーダー追加する位置をBorderPositionsStructにて指定
    ///  - parameter width:    ボーダーサイズを指定
    ///  - parameter color:    ボーダーカラーを指定
    public func addBorder(position:BorderPositions, width:CGFloat, color:UIColor) {
        if position.intersect(BorderPositions.Top) != [] {
            let line = UIView(frame:CGRectMake(0, 0, self.frame.size.width, width))
            line.backgroundColor = color
            line.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin
            self.addSubview(line)
        }
        
        if position.intersect(BorderPositions.Left) != [] {
            let line = UIView(frame:CGRectMake(0, 0, width, self.frame.size.height))
            line.backgroundColor = color
            line.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
            self.addSubview(line)
        }
        
        if position.intersect(BorderPositions.Bottom) != [] {
            let line = UIView(frame:CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width))
            line.backgroundColor = color
            line.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin
            self.addSubview(line)
        }
        
        if position.intersect(BorderPositions.Right) != [] {
            let line = UIView(frame:CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height))
            line.backgroundColor = color
            line.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
            self.addSubview(line)
        }
    }
    
    
    
    // MARK: - animations
    
    ///  Viewをフェードインさせる
    ///
    ///  - parameter duration:   アニメーションのインターバルを指定
    ///  - parameter completion: アニメーション完了時に実行するblockを指定
    public func fadeIn(duration:Double = 0.3, completion:(() -> Void)? = nil) {
        if self.hidden {
            self.alpha = 0.0
            self.hidden = false
        }
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.alpha = 1.0
            }) { (finished) -> Void in
                completion?()
        }
    }
    
    
    ///  Viewをフェードアウトさせる
    ///
    ///  - parameter duration:   アニメーションのインターバルを指定
    ///  - parameter completion: アニメーション完了時に実行するblockを指定
    public func fadeOut(duration:Double = 0.3, completion:(() -> Void)? = nil) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.alpha = 0.0
            }) { (finished) -> Void in
                self.alpha = 1.0
                self.hidden = true
                completion?()
        }
    }
    
    
    /// Viewを90%の縮小状態から通常に戻すアニメーション
    public func heartBeat() {
        let orgTransform = self.transform
        
        self.transform = CGAffineTransformMakeScale(0.9, 0.9)
        
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
            self.transform = orgTransform
            }) { (suceeded) -> Void in
        }
    }
    
    
    ///  Viewをポップさせる
    ///
    ///  - parameter groupDuration: ポップ開始から終了までのアニメーション間隔を指定する
    public func startPopAnimation(groupDuration: CFTimeInterval = 3.5) {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = groupDuration
        animationGroup.repeatCount = Float.infinity
        let timing = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [0, 0.2, 0, 0.2, 0]
        animation.keyTimes = [0, 0.1, 0.4, 0.5, 0.8, 1]
        animation.duration = CFTimeInterval(1)
        animation.additive = true
        animation.timingFunction = timing
        animationGroup.animations = [animation]
        self.layer.addAnimation(animationGroup, forKey: "popAnimation")
    }
    
    
    ///  Viewのポップアニメーションを止める
    public func stopPopAnimation() {
        self.layer.removeAnimationForKey("popAnimation")
    }
    
    
    ///  Viewをバウンスさせる
    ///
    ///  - parameter expandScale: 拡大の最大比率を指定
    func bounceAnimation(expandScale: CGFloat = 1.1) {
        UIView.animateWithDuration(0.1, delay: 0,
            options: .CurveEaseInOut,
            animations: {
                self.transform = CGAffineTransformMakeScale(expandScale, expandScale)
            },
            completion: { (finished: Bool) in
                UIView.animateWithDuration(0.1, delay: 0,
                    options: .CurveEaseInOut,
                    animations: {
                        self.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: nil)
        })
    }

    
    ///  Viewにシャドウを追加する
    ///
    ///  - parameter type:         シャドウのタイプをenum指定
    ///  - parameter color:        シャドウのカラーを指定
    ///  - parameter shadowOffset: シャドウのオフセットを指定
    public func addDropShadow(type:DropShadowType = .Dynamic, color: UIColor = UIColor.blackColor(), shadowOffset:CGSize = CGSizeZero) {
        
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowColor = color.CGColor
        
        switch type {
        case .Circle:
            let halfWidth = self.frame.size.width * 0.5
            self.layer.shadowPath = UIBezierPath(arcCenter: CGPointMake(halfWidth, halfWidth), radius: halfWidth, startAngle: 0.0, endAngle: CGFloat(M_PI) * 2, clockwise: true).CGPath
            
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.mainScreen().scale
        case .Rect:
            self.layer.shadowPath = UIBezierPath(roundedRect: self.frame, cornerRadius: self.layer.cornerRadius).CGPath
            
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.mainScreen().scale
        case .Dynamic:
            break
        }
        
    }
    
    
    ///  アイコンViewにシャドウを追加する
    public func addDropShadowForIcon() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 0.5
        self.layer.shadowOffset = CGSizeMake(0, 1)
        self.layer.shadowColor = UIColor.blackColor().CGColor
    }

}