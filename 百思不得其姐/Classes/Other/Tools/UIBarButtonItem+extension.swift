//
//  UIBarButtonItem+extension.swift
//  百思不得其姐
//
//  Created by yangtao on 3/17/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
extension UIBarButtonItem {


    
    class func itemWithImage(imageNamed:String, highlightedImageNamed:String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let custom:UIButton = UIButton()
        
        custom.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
      
        custom.setBackgroundImage(UIImage(named: imageNamed), forState: UIControlState.Normal)
        custom.setBackgroundImage(UIImage(named: highlightedImageNamed), forState: UIControlState.Highlighted)
        let customItem:UIBarButtonItem = UIBarButtonItem(customView: custom)
          custom.sizeToFit()
        return customItem
    }
    
    
    
    class func itemWithImage(imageNamed:String, highlightedImageNamed:String,title:String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let custom:UIButton = UIButton()
        
        custom.setImage(UIImage(named: imageNamed), forState: UIControlState.Normal)
        custom.setTitle(title, forState: UIControlState.Normal)
        custom.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        custom.setImage(UIImage(named: imageNamed), forState: UIControlState.Highlighted)
        custom.setTitle(title, forState: UIControlState.Highlighted)
        custom.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
       
        let customItem:UIBarButtonItem = UIBarButtonItem(customView: custom)
        custom.sizeToFit()
        
        custom.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        return customItem
    }

    
    
    class func itemWithTitle(title:String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        
        let customBtn = UIButton()
        customBtn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        customBtn.setTitle(title, forState: UIControlState.Normal)
        customBtn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
      customBtn.sizeToFit()
        let customItem:UIBarButtonItem = UIBarButtonItem(customView: customBtn)
        
        return customItem
    }
    
    
    
    convenience init(imageName:String, target: AnyObject?, action: String?)
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        if action != nil
        {
            btn.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        }
        btn.sizeToFit()
        self.init(customView: btn)
    }


}