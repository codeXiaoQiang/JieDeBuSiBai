//
//  PublishView.swift
//  百思不得其姐
//
//  Created by yangtao on 3/20/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import pop

private let  AnimationDelay:Double = 0.1;
private let  SpringFactor:CGFloat = 10;

var customWindow:UIWindow?
class PublishView: UIView {

    class func addPublish() -> PublishView {
    
        return NSBundle.mainBundle().loadNibNamed("PublishView", owner: nil, options: nil).last as! PublishView
    }
    
   class func showPublishView() {
        
        customWindow = UIWindow()
        customWindow?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        customWindow?.frame = UIScreen.mainScreen().bounds
        customWindow?.hidden = false
        
        let publish = PublishView.addPublish()
        publish.frame =  UIScreen.mainScreen().bounds
        customWindow?.addSubview(publish)
    }

    override func awakeFromNib() {
        
        // 不能被点击
        self.userInteractionEnabled = false
            
            // 数据
            let  images = ["publish-video", "publish-picture", "publish-text", "publish-audio", "publish-review", "publish-offline"];
            let  titles = ["发视频", "发图片", "发段子", "发声音", "审帖", "离线下载"];
            
            // 中间的6个按钮
            let maxCols = 3;
            let buttonW:CGFloat = 72;
            let buttonH :CGFloat = buttonW + 30;
            let buttonStartY:CGFloat =  (ScreenHeight - 2 * buttonH) * 0.5
            let buttonStartX:CGFloat = 20
            let xMargin:CGFloat = (ScreenWidth - 2 * buttonStartX - (CGFloat)(maxCols) * buttonW) / (CGFloat)(maxCols - 1)
        
            for var i = 0; i < images.count; i++ {
                
                let button = VerticalButton()
                button.tag = i;
                button.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
                addSubview(button)

                // 设置内容
                button.titleLabel!.font = UIFont.systemFontOfSize(14)
                button.setTitle(titles[i], forState: UIControlState.Normal)
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                button.setImage(UIImage(named: images[i]), forState: UIControlState.Normal)
               
                // 计算X\Y
                let row:Int = i / maxCols;
                let  col:Int = i % maxCols;
                let  buttonX :CGFloat = buttonStartX + (CGFloat)(col) * (xMargin + buttonW);
                let buttonEndY:CGFloat = buttonStartY + (CGFloat)(row) * buttonH;
                let buttonBeginY:CGFloat = buttonEndY - ScreenHeight;
                
                // 按钮动画
               let anim = POPSpringAnimation(propertyNamed: kPOPViewFrame)
                anim.fromValue = NSValue(CGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH))
                anim.toValue = NSValue(CGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH))
                
                //弹跳系数
                anim.springBounciness = SpringFactor;
                anim.springSpeed = SpringFactor;
                
                //动画执行时间
                anim.beginTime = CACurrentMediaTime() + AnimationDelay * (Double)(i);
                
                anim.completionBlock = {(animation, finished) in
                    
                         self.userInteractionEnabled = true
                }

                
                //添加动画
                button.pop_addAnimation(anim, forKey: nil)
            }
            
            // 添加标语
            addSubview(sloganView)
        
            // 标语动画
            let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            let centerX :CGFloat = ScreenWidth * 0.5
            let centerEndY:CGFloat = ScreenHeight * 0.2
            let centerBeginY:CGFloat = centerEndY - ScreenHeight;

            anim.fromValue = NSValue(CGPoint: CGPointMake(centerX, centerBeginY))
            anim.toValue = NSValue(CGPoint: CGPointMake(centerX, centerEndY))
            
            //动画执行时间
            anim.beginTime = CACurrentMediaTime() + (Double)(images.count) * AnimationDelay
        
            //弹跳系数
            anim.springBounciness = SpringFactor;
            anim.springSpeed = SpringFactor;
        
            //添加动画
            sloganView.pop_addAnimation(anim, forKey: nil)
        }
    
    @IBAction func close(sender: AnyObject) {
        
        cancelWithCompletionBlock { (completionBlock) -> () in
            
        }
    }
    
    func buttonClick(btn:UIButton) {
    
        cancelWithCompletionBlock { (completionBlock) -> () in
            if completionBlock {
            
                if btn.tag == 0 {
                    print("发视频")
                }else if (btn.tag == 1) {
                    print("发图片")
                }

            }
        }
        
    }
  
    private func cancelWithCompletionBlock(finfish:(completionBlock:Bool) -> ()) {
        
        // 不能被点击
        self.userInteractionEnabled = false
        
        let beginIndex: Int = 1
        for var i = beginIndex; i < self.subviews.count; i++ {
            
            let subview = self.subviews[i]
            // 基本动画
            let anim = POPBasicAnimation(propertyNamed: kPOPViewCenter)
            let centerY: CGFloat = subview.centerY + ScreenHeight
            anim.fromValue  = NSValue(CGPoint: CGPointMake(subview.centerX, subview.centerY))
            anim.toValue = NSValue(CGPoint: CGPointMake(subview.centerX, centerY))
            
            anim.beginTime = CACurrentMediaTime() + (Double)((i - beginIndex)) * AnimationDelay;
            subview.pop_addAnimation(anim, forKey: nil)
            
            // 监听最后一个动画
            if i == self.subviews.count - 1 {
                anim.completionBlock = {(animation, finished) in
                    
                    customWindow?.hidden = true
                    
                    finfish(completionBlock:finished)
                }
            }
        }

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        cancelWithCompletionBlock { (completionBlock) -> () in
            
        }
    }

    private lazy var sloganView:UIImageView =  {
        
        let sloganView = UIImageView(image: UIImage(named:"app_slogan"))
        return sloganView
    }()
}
