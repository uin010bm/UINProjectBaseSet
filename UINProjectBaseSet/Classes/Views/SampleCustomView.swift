//
//  SampleCustomView.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import UIKit

@objc protocol SampleCustomViewDelegate {
    optional func tappedButton(view: SampleCustomView)
    optional func tappedPushButton(view: SampleCustomView)
}

@IBDesignable class SampleCustomView: PBSBaseView {
    
    weak var delegate: SampleCustomViewDelegate?

    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonTapped(sender: AnyObject) {
        self.delegate?.tappedButton?(self)
    }
    
    @IBAction func pushButtonTapped(sender: AnyObject) {
        self.delegate?.tappedPushButton?(self)
    }
}
