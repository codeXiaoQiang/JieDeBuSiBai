//
//  VideoView.swift
//  百思不得其姐
//
//  Created by yangtao on 3/21/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import KRVideoPlayer
import pop
class VideoView: UIView {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videotimeLabel: UILabel!
    @IBOutlet weak var playcountLabel: UILabel!
    
    var videoController:KRVideoPlayerController?
    var videoModel:TopCommonModel? {
        
        didSet {
                        
            let urlString = NSURL(string: videoModel!.image1!)
            imageView.sd_setImageWithURL(urlString)
            
            // 播放次数
            playcountLabel.text = "\(videoModel!.playcount!)" + "次播放"
            
            // 时长
            let minute = (Int)(videoModel!.videotime!) / 60;
            let second = (Int)(videoModel!.videotime!) % 60;
            videotimeLabel.text = "\(minute)" + ":" + "\(second)"
        }
    }
    
    class func addvideoView() -> VideoView {
        
        let videoView =  NSBundle.mainBundle().loadNibNamed("VideoView", owner: nil, options: nil).last as? VideoView
        return videoView!
    }
    
    override func awakeFromNib() {
        self.autoresizingMask = .None
        
        //给图片添加响应事件
        imageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: "didClickPicture")
        imageView.addGestureRecognizer(gesture)
        
        // 监听CommentContrller返回的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "CommentContrllerDismiss", name: VideoDismissDidNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "CommentToBottomScroll:", name: CommentScrollToBottomDidNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "CommentToTopScroll", name: CommentScrollToTopDidNotification, object: nil)

        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
  
    
    func CommentContrllerDismiss() {
        if videoController != nil {
            videoController!.pause()
            videoController?.view.removeFromSuperview()
            videoController = nil
        }
  
        print(__FUNCTION__)
    }
    
    @IBAction func playOrStop(sender: AnyObject) {

         let url = NSURL(string: (videoModel?.videouri)!)
         playVideoWithURL(url!)
    }

    
    private func playVideoWithURL(url:NSURL) {
        
     if (videoController == nil) {
            
        videoController =  KRVideoPlayerController(frame: self.bounds)
        //监听屏幕缩小
        let willBackOrientationPortrait:() -> Void = {
            
            self.videoController?.view.removeFromSuperview()
            self.videoController?.frame =  self.bounds
            self.addSubview(self.videoController!.view)
            self.videoController!.view.alpha = 0.0
            UIView.animateWithDuration(0.3) { () -> Void in
                self.videoController!.view.alpha = 1.0
            }
        }
        
        //监听屏幕全屏
        let willChangeToFullscreenMode:() -> Void = {
            
            self.videoController?.view.removeFromSuperview()
            let keyWindow = UIApplication.sharedApplication().keyWindow
            keyWindow?.addSubview(self.videoController!.view)
            self.videoController!.view.alpha = 0.0
            UIView.animateWithDuration(0.3) { () -> Void in
                self.videoController!.view.alpha = 1.0
            }
        }
        
        videoController!.willBackOrientationPortrait = willBackOrientationPortrait
        videoController!.willChangeToFullscreenMode = willChangeToFullscreenMode
        
        //播放完毕
        videoController!.dimissCompleteBlock = {
            
            self.videoController?.view.removeFromSuperview()
                self.videoController = nil
        }
       
        show()
        }
        
        videoController!.contentURL = url
    }
    
    func show() {
        
        self.addSubview(videoController!.view)
//        videoController!.view.alpha = 0.0
//        UIView.animateWithDuration(0.3) { () -> Void in
//            self.videoController!.view.alpha = 1.0
//        }
    }
    
    func CommentToTopScroll() {
        
        if videoController != nil {
        
            self.videoController?.view.removeFromSuperview()
            self.addSubview(self.videoController!.view)
       
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                     self.videoController?.frame =  self.bounds
            })

        }
    }
    
    func CommentToBottomScroll(notifi:NSNotification) {
        
        if videoController != nil {
            
        
            self.videoController?.view.removeFromSuperview()
            let keyWindow = UIApplication.sharedApplication().keyWindow
            keyWindow?.addSubview(self.videoController!.view)
            
            let videoW:CGFloat = 100
            let videoH:CGFloat = videoW
            let rect = CGRectMake(ScreenWidth - videoW, 84, videoW, videoH)
         

            UIView.animateWithDuration(0.4, animations: { () -> Void in
                  self.videoController?.frame =  rect
                
                //使用kvc做缩放
                //self.videoController?.view.layer .setValue("0.5", forKeyPath: "transform.scale")
            })

        }
    }

    // MARK:-  查看大图
    func didClickPicture() {
        
        let keywoindow = UIApplication.sharedApplication().keyWindow
        keywoindow?.rootViewController?.presentViewController(CheckPictureController(model:videoModel)
            , animated: true, completion: nil)
    }
    
    func reset() {
        
        CommentContrllerDismiss()
    }
}
