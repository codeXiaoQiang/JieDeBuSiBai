//
//  TopWindow.swift
//  百思不得其姐
//
//  Created by yangtao on 3/23/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
var statuswindow:UIWindow?

class TopWindow: NSObject {

    var topwindow:UIWindow?
    override class func initialize() {
    
        statuswindow = UIWindow()
        statuswindow?.backgroundColor = UIColor.clearColor()
        statuswindow?.frame = CGRectMake(0, 0, ScreenWidth, 20)
        statuswindow?.windowLevel = UIWindowLevelAlert
        let tap = UITapGestureRecognizer(target: self, action: "windowClick")
        statuswindow?.addGestureRecognizer(tap)
    }
    
    /**
    * 监听窗口点击
    */
    
    class func windowClick() {
        
        let window = UIApplication.sharedApplication().keyWindow
        searchScrollViewInView(window!)
    }
    
    class func show() {
        
        statuswindow?.hidden = false
    }
    
    class func hiden() {
        statuswindow?.hidden = true
    }
    
    class func searchScrollViewInView(superview:UIView) {
        
        for subview in superview.subviews {
           
            // 如果是scrollview, 滚动最顶部
            if subview.isKindOfClass(UIScrollView.classForCoder()) && subview.isShowingOnKeyWindow() {
            
                if let scrollsubview = subview as? UIScrollView {
                
                    var offset:CGPoint = scrollsubview.contentOffset
                    offset.y = -scrollsubview.contentInset.top
                    scrollsubview.setContentOffset(offset, animated: true)

                }
            }
            // 继续查找子控件
            searchScrollViewInView(subview)
        }
    }
    
}
