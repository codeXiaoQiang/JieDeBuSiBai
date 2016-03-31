//
//  LoginViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/19/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginViewLeftMargin:NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginOrregister(btn: UIButton) {
        
        view.endEditing(true)
        
        if loginViewLeftMargin.constant == 0 {
            
            loginViewLeftMargin.constant = -view.width
            btn.selected = true
            btn.setTitle("已有账号?", forState: UIControlState.Normal)
        }else {
        
            loginViewLeftMargin.constant = 0
            btn.selected = false
            btn.setTitle("注册账号" , forState: UIControlState.Normal)
        }
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func close(btn: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    /**
    * 让当前控制器对应的状态栏是白色
    */

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
