//
//  SampleCustomView.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import UIKit

///  SampleCustomView Protocol
@objc protocol SampleCustomViewDelegate {
    
    /// SampleCustomViewからボタンのタップを受け付ける
    ///
    ///  - parameter view: 移譲元
    optional func tappedButton(view: SampleCustomView)
    
    /// SampleCustomViewからPush遷移を受け付ける
    ///
    ///  - parameter view: 移譲元
    optional func tappedPushButton(view: SampleCustomView)
}


/// Xibを利用したViewのサンプルクラス
@IBDesignable class SampleCustomView: PBSBaseXibView {
    
    /// SampleCuntomViewの移譲先を格納
    weak var delegate: SampleCustomViewDelegate?
    
    @IBOutlet weak var scrollButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    /// textをセットする
    internal func setupLocalization() {
        self.scrollButton.setTitle(Localize("UISampleView.scrollButton"), forState: .Normal)
        self.nextButton.setTitle(Localize("UISampleView.nextButton"), forState: .Normal)
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        self.delegate?.tappedButton?(self)
    }
    
    @IBAction func pushButtonTapped(sender: AnyObject) {
        self.delegate?.tappedPushButton?(self)
    }
}
