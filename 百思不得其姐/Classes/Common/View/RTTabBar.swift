//
//  RTTabBar.swift
//  百思不得其姐
//
//  Created by yangtao on 3/7/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
class RTTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame:frame)

        setupUI()
    }
    
    private func setupUI(){
        
        backgroundImage = UIImage(named:"tabbar-light")
        publishButton.setBackgroundImage(UIImage(named: "tabBar_publish_icon"), forState: UIControlState.Normal)
        publishButton.setBackgroundImage(UIImage(named: "tabBar_publish_click_icon"), forState: UIControlState.Highlighted)
        publishButton.frame.size = (publishButton.currentBackgroundImage?.size)!
        addSubview(publishButton)
        
        publishButton.addTarget(self, action: "didClickPublish", forControlEvents: UIControlEvents.TouchUpInside)
    }
    

    var customWindow:UIWindow?
    //发布按钮
    func didClickPublish() {
        
        PublishView.showPublishView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var publishButton:UIButton = {
    
        let publishButton = UIButton(type: UIButtonType.Custom)
        
        return publishButton
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var index:NSInteger = 0
        for btn:UIView in subviews {
            if btn == publishButton || !btn.isKindOfClass(UIControl.classForCoder()){
            
                publishButton.center = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5)
            }else {
                // 根据索引调整位置
                setupTabBarButtonFrame(btn, index: index)
                
                // 增加索引
                index++
            }
        }
    }
    
    private func setupTabBarButtonFrame(tabBarButton:UIView ,index:NSInteger) {
    
        // 设置其他UITabBarButton的frame
        let width = self.frame.size.width
        let height = self.frame.size.height
        let buttonY:CGFloat = 0
        let buttonW:CGFloat = width / 5
        let buttonH:CGFloat = height
        
        tabBarButton.frame.size.height = buttonH
        tabBarButton.frame.size.width = buttonW
        tabBarButton.frame.origin.y = buttonY
        
        if index >= 2 {
        
            tabBarButton.frame.origin.x = (CGFloat)(buttonW * (CGFloat)(index + 1));
        }else {
            
            tabBarButton.frame.origin.x = (CGFloat)(buttonW * (CGFloat)(index))
        }
    }
}
