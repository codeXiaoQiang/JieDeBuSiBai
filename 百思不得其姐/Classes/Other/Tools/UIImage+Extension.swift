//
//  UIImage+Extension.swift
//  百思不得其姐
//
//  Created by yangtao on 3/23/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

extension UIImage {
    
    func circle() -> UIImage {
    
        //第一步开启上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        //第二步获得上下文
        let ctx = UIGraphicsGetCurrentContext()
        
        //画一个圆
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextAddEllipseInRect(ctx, rect)
        //对圆进行裁剪
        CGContextClip(ctx)
        
        //将图片添加到上下文中
        drawInRect(rect)
        
        let circleImage = UIGraphicsGetImageFromCurrentImageContext()
        //结束上下文
        UIGraphicsEndImageContext()
        
        return circleImage
    }
}