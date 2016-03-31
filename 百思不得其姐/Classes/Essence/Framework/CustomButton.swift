//
//  CustomButton.swift
//  百思不得其姐
//
//  Created by yangtao on 3/15/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = UIFont.systemFontOfSize(14)
       
        setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
        titleLabel?.textAlignment = NSTextAlignment.Center
        backgroundColor  = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var scale:CGFloat? {
    
        didSet {
            
            if let btnScale = scale {
                //渐变颜色
                let RedScale:CGFloat = 0.6
                let GreenScale:CGFloat = 0.6
                let BlueScale:CGFloat = 0.6
                let AlphaScale:CGFloat = 1.0
                
                let red = RedScale + (1 - RedScale) * btnScale
                 let green = GreenScale + (0 - GreenScale) * btnScale
                 let blue = BlueScale + (0 - BlueScale) * btnScale
                
                setTitleColor(UIColor(red: red, green: green, blue: blue, alpha: AlphaScale), forState: UIControlState.Selected)
                
                //大小缩放
                let transformScale = 1+btnScale*0.3
                transform = CGAffineTransformMakeScale(transformScale, transformScale)

            }
        }
    }
}
