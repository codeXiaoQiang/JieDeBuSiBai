//
//  UIView+extension.swift
//  百思不得其姐
//
//  Created by yangtao on 3/17/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Get Set x Position
     
     - parameter x: CGFloat
     by DaRk-_-D0G
     */
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    /**
     Get Set y Position
     
     - parameter y: CGFloat
     by DaRk-_-D0G
     */
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    /**
     Get Set Height
     
     - parameter height: CGFloat
     by DaRk-_-D0G
     */
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    /**
     Get Set Width
     
     - parameter width: CGFloat
     by DaRk-_-D0G
     */
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var size:CGSize {
        
        get {
            return self.frame.size
        }
        set {
            
            self.frame.size = newValue
        }
    }
    
    var centerX:CGFloat {
        
        get {
            
            return self.center.x
        }
        
        set {
            
            self.center.x = newValue
        }
    }
    
    var centerY:CGFloat {
        
        get {
            
            return self.center.y
        }
        
        set {
            
            self.center.y = newValue
        }
    }
    
    func isShowingOnKeyWindow() -> Bool {
 
        // 主窗口
        let keyWindow = UIApplication.sharedApplication().keyWindow
        
         // 以主窗口左上角为坐标原点, 计算self的矩形框
        let newFrame = keyWindow?.convertRect(self.frame, fromView: self.superview)
        let winBounds = keyWindow?.bounds
        
        // 主窗口的bounds 和 self的矩形框 是否有重叠
        let intersects:Bool = CGRectIntersectsRect(newFrame!, winBounds!)
        
        if hidden == false && self.alpha > 0.01  && self.window == keyWindow && intersects {
            
            return true
        }else {
        
            return false
        }

    }
   
}
