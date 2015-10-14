//
//  PBSBaseView.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//


import UIKit

class PBSBaseView: UIView {
    
    // MARK: - private propertys
    // Our custom view from the XIB file
    private var view: UIView!
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
        Log("PBSBaseView init!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
    }
    
    deinit {
        Log("PBSBaseView deinit!!")
    }
    
    
    
    // MARK: - private functions
    /**
    Setting xib and size.
    */
    private func setupXib() {
        self.view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        self.view.frame = self.bounds
        
        // Make the view stretch with containing view
        self.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        self.addSubview(view)
    }
    
    
    /**
    Load nib file.
    
    :returns: loaded view from xib
    */
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: self.getClassNameWithoutNamespace(), bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
}
