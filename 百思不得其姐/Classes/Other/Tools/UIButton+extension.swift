//
//  UIButton+extension
//  百思不得其姐
//
//  Created by yangtao on 3/17/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

extension  UIButton {
    
    class func setButton(imgaeName:String ,title:String, font:CGFloat, color:UIColor) -> UIButton {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imgaeName), forState: UIControlState.Normal)
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(color, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(font)
        
        return btn
    }
}