//
//  SecondViewController.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/16.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import UIKit


/// 2つめに表示されるViewController
class SecondViewController: UIViewController {

    
    // MARK: - outlets propertys
    @IBOutlet var customView: SampleCustomView!
    
    
    // MARK: - private propertys
    private var scrollView: UIScrollView!
    
    
    
    // MARK: - initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log("SecondViewController init!")
    }
    
    deinit {
        Log("SecondViewController deinit!!!")
    }
    
    
    // MARK: - viewController delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.customView.setupLocalization()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setupView()
    }
    
    
    
    // MARK: - private functions
    
    ///  Viewの初期設定をする
    private func setupView() {
        self.addSampleView()
    }
    
    
    ///  SampleViewをappendする
    private func addSampleView() {
        
        self.scrollView = UIScrollView()
        self.scrollView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height)
        
        let image = UIImage.getGradationImageWith(size: CGSizeMake(self.view.frame.size.width, 2000), startFrom: UIImage.GradationStart.Top, colors: [UIColor.whiteColor(), UIColor.blackColor()])
        let samView = UIImageView(frame: CGRectMake(0, 0, image.size.width, image.size.height))
        samView.image = image
        
        self.scrollView.addSubview(samView)
        self.scrollView.contentSize = CGSizeMake(samView.frame.size.width, samView.frame.size.height)
        
        self.customView.addSubview(scrollView)
        
    }
    
    ///  Logイベント
    private func firedEvent() {
        Log("event is fired.")
    }
}


// MARK: - delegate : SampleCustomViewDelegate
extension SecondViewController: SampleCustomViewDelegate {
    
    
    /// SampleCustomViewからボタンのタップを受け付ける
    ///
    ///  - parameter view: 移譲元
    internal func tappedButton(view: SampleCustomView) {
        self.scrollView.handleScrollRectToVisible(CGRectMake(0, 1900, 1, 100), animated: true, completion: { [weak self] in
            self?.firedEvent()
        })
    }
    
    /// SampleCustomViewからPush遷移を受け付ける
    ///
    ///  - parameter view: 移譲元
    internal func tappedPushButton(view: SampleCustomView) {
        self.performSegueWithIdentifier("pushToSecond", sender: self)
    }
}