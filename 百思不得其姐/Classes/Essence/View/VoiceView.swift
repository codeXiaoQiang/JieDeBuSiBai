//
//  VoiceView.swift
//  百思不得其姐
//
//  Created by yangtao on 3/21/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SDWebImage
import DOUAudioStreamer


class VoiceView: UIView {

    var indexRow:Int = 0
    var saveLastIndexRow:Int = 0
    var AudioStreamer:DOUAudioStreamer?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var voicetimeLabel: UILabel!
    @IBOutlet weak var playcountLabel: UILabel!
    
    @IBOutlet weak var playOrStop: UIButton!
    /** 滑块*/
    @IBOutlet weak var slider: UIButton!
    /**播放进度条*/
    @IBOutlet weak var progressView: UIView!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var Sliderleading: NSLayoutConstraint!
    
    var currentTimeTimer:NSTimer?
    
    var voiceModel:TopCommonModel? {
        
        didSet {
            
            // 给AudioPlayModel的属性赋值
            if let audioUrlSting = voiceModel?.voiceuri {
                let audioUrlFileModel = AudioPlayModel()
                audioUrlFileModel.audioURL = audioUrlSting
                AudioStreamer = DOUAudioStreamer(audioFile:audioUrlFileModel)
            }
            
            //图片
            let urlString = NSURL(string: voiceModel!.image1!)
            imageView.sd_setImageWithURL(urlString)
            
            // 播放次数
            playcountLabel.text = "\(voiceModel!.playcount!)" + "次播放"

            // 时长
            let minute = (Int)(voiceModel!.voicetime!) / 60
            let second = (Int)(voiceModel!.voicetime!) % 60
            
            voicetimeLabel.text = "\(minute)" + ":" + "\(second)"
        }
    }
    
    class func addVoiceView() -> VoiceView {
        
        let voiceView =  NSBundle.mainBundle().loadNibNamed("VoiceView", owner: nil, options: nil).last as? VoiceView
        
        return voiceView!
    }
    
    override func awakeFromNib() {
        self.autoresizingMask = .None
        
        //给音频背景图片添加响应事件
        imageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: "didClickPicture")
        imageView.addGestureRecognizer(gesture)
        
        //给音频播放图片添加响应事件
        playOrStop.addTarget(self, action: "didClickAudioPlay", forControlEvents: UIControlEvents.TouchUpInside)

        //给进度背景添加点击手势
        bgView.userInteractionEnabled = true
        let gesturebgView = UITapGestureRecognizer(target: self, action: "onProgressBgTap:")
        bgView.addGestureRecognizer(gesturebgView)
        
        //滑块拖动手势
        let gestureslider = UIPanGestureRecognizer(target: self, action: "panSlider:")
        slider.addGestureRecognizer(gestureslider)
    }
    
    // MARK:-  查看大图
    func didClickPicture() {
    
        let keywoindow = UIApplication.sharedApplication().keyWindow
        keywoindow?.rootViewController?.presentViewController(CheckPictureController(model:voiceModel)
            , animated: true, completion: nil)
    }
    
    // MARK:-  播放音频
    func didClickAudioPlay() {
    
        
        if AudioStreamer != nil {
        
            if saveLastIndexRow == indexRow {
                
                if !playOrStop.selected {
                    
                    playOrStop.selected = true
                    AudioStreamer!.play()
                    
                    //添加定时器
                    addCurrentTimeTimer()

                }else {
                    playOrStop.selected = false
                    removeCurrentTimeTimer()
                    AudioStreamer!.pause()
                }
                
            }else {
                
                //停止上一个cell的播放
                AudioStreamer!.pause()
                
                //开始新的播放
                AudioStreamer!.play()
                
                //添加定时器
                addCurrentTimeTimer()
                
                //保存上一次选中的行
                saveLastIndexRow = indexRow
                
                playOrStop.selected = true

            }
        }
    }
    
    func addCurrentTimeTimer() {
        
        //移除当前的定时器
        removeCurrentTimeTimer()
        
        // 跟新定时器
        updateCurrentTime()
        
        //添加定时器
        currentTimeTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateCurrentTime", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(currentTimeTimer!, forMode: NSRunLoopCommonModes)
    }
    
    
    func removeCurrentTimeTimer() {
        currentTimeTimer?.invalidate()
        currentTimeTimer = nil
    }
    
    func updateCurrentTime() {
    
        if AudioStreamer != nil {
        
            // 1.计算进度值
            if AudioStreamer!.duration != 0 {
                    
                let progress = AudioStreamer!.currentTime / (NSTimeInterval )(voiceModel!.voicetime!)
                
                // 2.设置滑块的x值
                let sliderMaxX = imageView.width - slider.width - voicetimeLabel.width
                Sliderleading.constant = sliderMaxX * (CGFloat)(progress)
                slider.x = Sliderleading.constant
                
                if Sliderleading.constant < 0 {
                    Sliderleading.constant = 0
                } else if (Sliderleading.constant > sliderMaxX) {
                    Sliderleading.constant = sliderMaxX
                }
                
                //设置进度时间
                let minute = (Int)(AudioStreamer!.currentTime) / 60
                let second = (Int)(AudioStreamer!.currentTime) % 60
                let timeString = "\(minute)" + ":" + "\(second)"
                slider.setTitle(timeString, forState: UIControlState.Normal)
                
                // 3.设置进度条的宽度
                progressView.width = self.slider.center.x
            }

        }
    }
    
    //进度条点击
    func onProgressBgTap(sender:UITapGestureRecognizer) {
        
        print("onProgressBgTaponProgressBgTap")

        let point = sender.locationInView(sender.view)
        // 切换歌曲的当前播放时间
        AudioStreamer!.currentTime = (NSTimeInterval)(point.x / sender.view!.width) * (NSTimeInterval )(voiceModel!.voicetime!)
        
        updateCurrentTime()
    }
    
    // 滑块拖动
    func panSlider(sender:UIPanGestureRecognizer) {
        
        // 获得挪动的距离
        let t = sender.translationInView(sender.view)
        //将translation清空，免得重复叠加
        sender.setTranslation(CGPointZero, inView: sender.view)
        
        // 控制滑块和进度条的frame
        let sliderMaxX = imageView.width - slider.width - voicetimeLabel.width
        Sliderleading.constant = Sliderleading.constant + t.x
        if Sliderleading.constant < 0 {
            Sliderleading.constant = 0
        } else if (Sliderleading.constant > sliderMaxX) {
            Sliderleading.constant = sliderMaxX
        }
        self.progressView.width = slider.center.x
        
        // 设置时间值
        let progress = Sliderleading.constant / sliderMaxX
        let time = (NSTimeInterval )(voiceModel!.voicetime!) * (NSTimeInterval )(progress)
        slider.setTitle("\(time)", forState: UIControlState.Normal)

        // 设置播放器的时间
        AudioStreamer!.currentTime = time
        
        if (sender.state == UIGestureRecognizerState.Began) {
            
            slider.setTitle("", forState: UIControlState.Normal)
            
            AudioStreamer!.pause()
            // 停止定时器
            removeCurrentTimeTimer()
            
        } else if (sender.state == UIGestureRecognizerState.Ended) { // 手松开
            
            AudioStreamer!.play()
            // 开始定时器
            addCurrentTimeTimer()
        }
    }
    
    func reset() {
    
        AudioStreamer?.stop()
        Sliderleading.constant = -2//默认值
        slider.setTitle("", forState: UIControlState.Normal)
    }
}
