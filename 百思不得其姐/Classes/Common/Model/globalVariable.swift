//
//  globalVariable.swift
//  百思不得其姐
//
//  Created by yangtao on 3/10/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.size.height
let  GlobalBg = RGBColor(233,g: 233, b: 233)
let margin:CGFloat = 10
let topheight:CGFloat = 35
let bottomHeight:CGFloat = 44
let picture_MAXHEIGHT:CGFloat = 1000
let picture_NORMAL:CGFloat = 350
func RGBColor (r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor{
    
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

let TabBarDidSelectNotification = "TabBarDidSelectNotification"
let VideoDismissDidNotification = "VideoDismissDidNotification"
let CommentScrollToBottomDidNotification = "CommentScrollToBottomDidNotification"
let CommentScrollToTopDidNotification = "CommentScrollToTopDidNotification"
class globalVariable: NSObject {

    
}
