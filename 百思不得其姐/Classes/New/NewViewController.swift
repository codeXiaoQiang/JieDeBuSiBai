//
//  NewViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/7/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class NewViewController: EssenceViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏标题
        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
    
        // 设置导航栏左边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.itemWithImage("MainTagSubIcon", highlightedImageNamed: "MainTagSubIconClick" , target: self, action: "tagClick")
        
        // 设置背景色
      view.backgroundColor = GlobalBg
    }
    
    func tagClick() {
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        // 让正在播放的视频暂停的通知
        NSNotificationCenter.defaultCenter().postNotificationName(VideoDismissDidNotification, object: self, userInfo: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
