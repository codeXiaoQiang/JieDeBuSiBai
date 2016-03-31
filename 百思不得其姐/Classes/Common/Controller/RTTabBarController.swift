//
//  RTTabBarController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/7/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class RTTabBarController: UITabBarController {

    //类第一次创建的时候调用,并且只会调用一次
    override class func initialize() {
        
        //设置默认tabbar的字体大小与颜色
        let normalStatusFont = [NSFontAttributeName : UIFont.systemFontOfSize(12)]
        let normalStatusColor = [NSForegroundColorAttributeName :UIColor.grayColor()]
       
        //设置选中状态的字体大小与颜色
        let selectStatusFont = [NSFontAttributeName : UIFont.systemFontOfSize(12)]
        let selectStatusColor = [NSForegroundColorAttributeName :UIColor.darkGrayColor()]
  
        let tabBarItem = UITabBarItem.appearance()
        tabBarItem.setTitleTextAttributes(normalStatusFont , forState: UIControlState.Normal)
        tabBarItem.setTitleTextAttributes(normalStatusColor , forState: UIControlState.Normal)
        tabBarItem.setTitleTextAttributes(selectStatusFont , forState: UIControlState.Selected)
        tabBarItem.setTitleTextAttributes(selectStatusColor, forState: UIControlState.Selected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加子控制器
        setupChildVc(EssenceViewController(), title: "精华" , image: "tabBar_essence_icon", selectedImage: "tabBar_essence_click_icon")
      
        setupChildVc(NewViewController(), title: "新帖" , image: "tabBar_new_icon", selectedImage: "tabBar_new_click_icon")
        
        setupChildVc(FriendTrendsViewController(), title: "关注" , image: "tabBar_friendTrends_icon", selectedImage: "tabBar_friendTrends_click_icon")
        
        let vc = MeViewController(style: .Grouped)
        setupChildVc(vc, title: "我" , image: "tabBar_me_icon", selectedImage: "tabBar_me_click_icon")
        
        // 自定义中间的按钮
        setValue(RTTabBar(), forKey: "tabBar")

    }
    
    /**
     * 初始化子控制器
     */
    private func setupChildVc(vc:UIViewController, title:String, image:String, selectedImage:String) {
        
        vc.navigationItem.title = title
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        let nav = RTNavigationController(rootViewController: vc)
        addChildViewController(nav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
