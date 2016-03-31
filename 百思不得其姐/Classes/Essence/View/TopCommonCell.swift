//
//  TopCommonCell.swift
//  百思不得其姐
//
//  Created by yangtao on 3/17/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import DOUAudioStreamer
let identifier = "TopCommonCell"
class TopCommonCell: UITableViewCell {

    /** 头像 */
    @IBOutlet weak var profileImageView:UIImageView?
    /** 昵称 */
     @IBOutlet weak var nameLabel:UILabel?
    /** 时间 */
     @IBOutlet weak var createTimeLabel:UILabel?
    /** 顶 */
     @IBOutlet weak var dingButton:UIButton?
    /** 踩 */
     @IBOutlet weak var caiButton:UIButton?
    /** 分享 */
     @IBOutlet weak var shareButton:UIButton?
    /** 评论 */
     @IBOutlet weak var commentButton:UIButton?
    @IBOutlet weak var sinaVView:UIImageView?

    @IBOutlet weak var text_label: UILabel!
    /** 最热评论的内容 */
    @IBOutlet weak var topCmtContentLabel: UILabel!
    /** 最热评论的整体 */
    @IBOutlet weak var topCmtView: UIView!
    
    var model:TopCommonModel? {
        didSet {
        
            if let commonModel = model {
            
                if commonModel.sina_v != nil {
                
                     self.sinaVView!.hidden = !commonModel.sina_v!
                }
               
                // 设置按钮文字
                if let dingvalue = commonModel.ding {
                    setupButtonTitle(dingButton!, count: dingvalue, placeHolder: "顶")
                }
                if let caivalue = commonModel.cai {
                    setupButtonTitle(caiButton!, count: caivalue, placeHolder: "踩")
                }
                if let repostvalue = commonModel.repost {
                    setupButtonTitle(shareButton!, count: repostvalue, placeHolder: "分享")
                }
                if let commentvalue = commonModel.comment {
                    setupButtonTitle(commentButton!, count:commentvalue, placeHolder: "评论")
                }

              
                // 设置其他控件                
                profileImageView?.sd_setImageWithURL(NSURL(string: commonModel.profile_image!), placeholderImage: UIImage(named: "defaultUserIcon"), completed: { (image, _, _, _) -> Void in
                    
                    let placeholder = UIImage(named: "defaultUserIcon")!.circle()
                    
                    if image != nil {
                         self.profileImageView?.image = image.circle()
                    }else {
                        self.profileImageView?.image = placeholder
                    }
                    
                })
               
                nameLabel!.text = commonModel.name;
                createTimeLabel!.text = dateString(commonModel)
                
                //设置文字内容
                text_label.text = commonModel.text
                
                //添加中间的类容
                if model?.type == commonType.PictureType.rawValue {
                    commonPictureView.hidden = false
                    
                    if let frame = model!.pictureFrame {
            
                        commonPictureView.frame = frame
                         self.contentView.addSubview(commonPictureView)
                    }
                    commonPictureView.pictureModel = commonModel
                    
                   commonVoiceView.hidden = true
                   commonVideoView.hidden = true
                }else if model?.type == commonType.VoiceType.rawValue {
                    
                    commonVoiceView.hidden = false
                    if let frame = model!.voiceFrame {
                        
                        commonVoiceView.frame = frame
                        self.contentView.addSubview(commonVoiceView)
                    }
                    commonVoiceView.voiceModel = commonModel
                    commonPictureView.hidden = true
                    commonVideoView.hidden = true
                }else if model?.type == commonType.VideoType.rawValue {
                    
                    commonVideoView.hidden = false
                    if let frame = model!.videoFrame {
                        
                        commonVideoView.frame = frame
                        self.contentView.addSubview(commonVideoView)
                    }
                    commonVideoView.videoModel = commonModel
                    
                    commonVoiceView.hidden = true
                    commonPictureView.hidden = true
                }else if model?.type == commonType.AllType.rawValue{ // 段子帖子
             
                    commonVideoView.hidden = false
                    commonVoiceView.hidden = false
                    commonPictureView.hidden = false
                }

                // 处理最热评论
                if ((commonModel.top_cmt) != nil) {
                    
                   topCmtView.hidden = false
                    topCmtContentLabel.text = (commonModel.top_cmt?.user?.username)! + (commonModel.top_cmt?.content)!
                } else {
                    
                    self.topCmtView.hidden = true
                }
              
           }
          
        }
        
    }
    
    private func dateString(commonModel:TopCommonModel) ->String {
        
        // 日期格式化类
        let fmt = NSDateFormatter()
        // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss";
        // 帖子的创建时间
        let create = fmt.dateFromString(commonModel.create_time!)! as NSDate
        
        if create.isThisYear() { // 今年
            if create.isToday() { // 今天
                let cmps = NSDate().deltaFrom(create)
                
                if cmps.hour >= 1 { // 时间差距 >= 1小时
                    let cmpsstring = "\(cmps.hour)" + "小时前";                          return cmpsstring
                    
                } else if cmps.minute >= 1 { // 1小时 > 时间差距 >= 1分钟
                    let cmpsstring = "\(cmps.minute)" + "分钟前";                     return cmpsstring
                    
                } else { // 1分钟 > 时间差距
                    return "刚刚"
                }
            } else if create.isYesterday() { // 昨天
                fmt.dateFormat = "昨天 HH:mm:ss"
                return fmt.stringFromDate(create)
                
            } else { // 其他
                fmt.dateFormat = "MM-dd HH:mm:ss"
                return fmt.stringFromDate(create)
            }
        } else { // 非今年
            return commonModel.create_time!
        }
    }


    private func setupButtonTitle(btn:UIButton, count:NSNumber, var placeHolder:String) {
        
        let intnumber = Int(count)
        
            let coutnumber = intnumber / 10000
            
            if (intnumber > 10000) {
                placeHolder = "\(coutnumber)" + "万"
                
            } else if (intnumber > 0) {
                placeHolder = "\(intnumber)"
                
            }
            btn.setTitle(placeHolder, forState: UIControlState.Normal)
    }

    class func cellwithTableView(tableView:UITableView) -> UITableViewCell {

        var cell = tableView .dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil) {
            
            cell = NSBundle.mainBundle().loadNibNamed("TopCommonCell", owner:self , options: nil).last as? UITableViewCell
        }
        
        return cell!
    }
    
    class func cellwithNib() -> TopCommonCell {
        
        let  cell = NSBundle.mainBundle().loadNibNamed("TopCommonCell", owner:self , options: nil).last as? TopCommonCell
     
        
        return cell!
    }
    
    func setIndexPath(index:NSIndexPath) {
        
        commonVoiceView.indexRow = index.row
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.image = UIImage(named:"mainCellBackground")
        backgroundView = bgView;
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        commonVoiceView.reset()
        commonVideoView.reset()
        print("------------")
    }
    

    private lazy var bgView:UIImageView =  {
    
        let bgView = UIImageView()
        return bgView
    }()


    //图片
    lazy var commonPictureView:PictureView =  {
    
        let commonPictureView = PictureView.addPictureView()
        
  
        return commonPictureView
    }()
    
    //声音
    lazy var commonVoiceView:VoiceView =  {
        
        let commonVoiceView = VoiceView.addVoiceView()
        return commonVoiceView
    }()
    
    //视频
    lazy var commonVideoView:VideoView =  {
        
        let commonVideoView = VideoView.addvideoView()
 
        return commonVideoView
    }()

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

    
    @IBAction func topMore(sender: AnyObject) {
        
        print(__FUNCTION__)
    }
}

