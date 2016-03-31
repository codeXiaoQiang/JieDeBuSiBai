//
//  RTNavigationController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/7/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class RTNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       navigationBar.setBackgroundImage(UIImage(named:"navigationbarBackgroundWhite"), forBarMetrics: UIBarMetrics.Default)
        interactivePopGestureRecognizer?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWithImage("navigationButtonReturn" , highlightedImageNamed: "navigationButtonReturnClick", title: "back", target: self, action: "didBack")
            
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    func didBack() {
        
        self.popViewControllerAnimated(true)
    }

}

extension RTNavigationController:UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
}

