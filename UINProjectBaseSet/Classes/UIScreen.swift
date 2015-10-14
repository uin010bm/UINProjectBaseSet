//
//  UIScreen.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import UIKit
import BlocksKit


extension UIScrollView {
    
    // MARK: public functions
    /**
    Set event hundling will fire when over setting rect.
    
    :param: rect       set target rect by CGRect
    :param: animated   set animation bool
    :param: completion set completion block
    */
    public func pbs_scrollRectToVisible(rect: CGRect, animated: Bool, completion:()->Void) {
        self.scrollRectToVisible(rect, animated: animated)
        let maxDuration:Double = 0.5
        var currentDuration:Double = 0.0
        
        let _ = NSTimer.bk_scheduledTimerWithTimeInterval(1.0/60.0, block: { (currentTimer) -> Void in
            
            let currentOffset:CGPoint = (self.layer.presentationLayer() as? CALayer)?.bounds.origin ?? self.contentOffset
            
            let minRectX = currentOffset.x + self.contentInset.left
            let maxRectX = currentOffset.x + self.frame.size.width
            let minRectY = currentOffset.y + self.contentInset.top
            let maxRectY = currentOffset.y + self.frame.size.height
            let contentSize = self.contentSize
            
            let minX = max(CGRectGetMinX(rect), 0)
            let maxX = min(CGRectGetMaxX(rect), contentSize.width)
            let minY = max(CGRectGetMinY(rect), 0)
            let maxY = min(CGRectGetMaxY(rect), contentSize.height)
            
            if minRectX <= minX && maxX <= maxRectX && minRectY <= minY && maxY <= maxRectY {
                currentTimer.invalidate()
                completion()
                return
            }
            if maxDuration <= currentDuration {
                currentTimer.invalidate()
                completion()
                return
            }
            currentDuration += 1.0/60.0
            
        }, repeats: true)
    }
}