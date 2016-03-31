//
//  PictureView.swift
//  百思不得其姐
//
//  Created by yangtao on 3/18/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SDWebImage
class PictureView: UIView {

   
    @IBOutlet weak var loadProgress: ProgressView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var pictureBtn: UIButton!
    @IBOutlet weak var gifImageView: UIImageView!
   
 
    class func addPictureView() -> PictureView {

        let pictureView =  NSBundle.mainBundle().loadNibNamed("PictureView", owner: nil, options: nil).last as? PictureView
        
        return pictureView!
    }
    
    override func awakeFromNib() {
        self.autoresizingMask = .None
        
        //给图片添加响应事件
        pictureImageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: "didClickPicture")
        pictureImageView.addGestureRecognizer(gesture)
        
        pictureBtn.addTarget(self, action: "didClickPicture", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
   // MARK:-  查看大图
    func didClickPicture() {
    
            let keywoindow = UIApplication.sharedApplication().keyWindow
    keywoindow?.rootViewController?.presentViewController(CheckPictureController(model:pictureModel)
, animated: true, completion: nil)
        
}
    
    var pictureModel:TopCommonModel? {
        
        didSet
        {
            
            // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
            if pictureModel?.pictureProgress != nil {
            
                    loadProgress.setProgress((pictureModel?.pictureProgress)!, animated: false)
            }
            
            //显示图片
            if let imageSting = pictureModel?.image1 {
            
                let urlString = NSURL(string: imageSting)
                self.pictureImageView.sd_setImageWithURL(urlString, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), progress: { (receivedSize, expectedSize) -> Void in
                    
                    self.loadProgress.hidden = false;
                    // 计算进度值
                    self.pictureModel!.pictureProgress = (CGFloat)(1.0 * (Double)(receivedSize / expectedSize));
                    // 显示进度值
                    if self.pictureModel?.pictureProgress != nil {
                        
                        self.loadProgress.setProgress(self.pictureModel!.pictureProgress!, animated: false)
                    }

                    
                    }, completed: { (image, error, cacheType, imageURL) -> Void in
                
                        
                        self.loadProgress.hidden = true;
                        
                        // 如果是大图片, 才需要进行绘图处理
                        if self.pictureModel!.islarge {
                        
                            // 开启图形上下文
                            UIGraphicsBeginImageContextWithOptions(self.loadProgress.size, true, 0.0);
                            
                            // 将下载完的image对象绘制到图形上下文
                            let width = self.loadProgress.size.width;
                            
                            if let pictureimage = image {
                            
                                let height = width * pictureimage.size.height / pictureimage.size.width;
                                pictureimage.drawInRect(CGRectMake(0, 0, width, height))

                            }
                           
                            // 获得图片
                            self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                            
                            // 结束图形上下文
                            UIGraphicsEndImageContext();

                        }
                       
                })

                // 判断是否为gif
                gifImageView.hidden = ((imageSting as NSString).pathExtension.lowercaseString == "gif") ? false:true
            
            }
            
            //是否显示按钮
            if  (pictureModel!.islarge) {
            
                pictureImageView.contentMode = UIViewContentMode.ScaleAspectFill;
                pictureBtn.hidden = false
            }else {
                pictureImageView.contentMode = UIViewContentMode.ScaleToFill;
                pictureBtn.hidden = true
            }

            
        }
    }
}
