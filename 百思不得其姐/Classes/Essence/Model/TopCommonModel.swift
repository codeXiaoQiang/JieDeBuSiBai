//
//  TopCommonModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/17/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import MJExtension

/** 最热评论 */
var top_cmt:[CommentModel]?
class TopCommonModel: NSObject {

    /** id */
    var id:String?

    /** 名称 */
    var name:String?
    
    /** 头像 */
    var profile_image:String?

    /** 发帖时间 */
    //var create_time:String?
    var create_time:String?
    /** 文字内容 */
    var text:String?
    /** 顶的数量 */
    var ding:NSNumber?
 
    /** 踩的数量 */
    var cai:NSNumber?

    /** 转发的数量 */
    var repost:NSNumber?
    
    /** 评论的数量 */
    var comment:NSNumber?

    var sina_v:Bool?
    
    /** 图片的宽度 */
    var width:String?
    /** 图片的高度 */
    var height:String?
      
    /** 小图片的URL */
     var image0:String?
    //var small_image:String?

    /** 中图片的URL */
     var image2:String?
    //var middle_image:String?

    /** 大图片的URL */
    var image1:String?
    //var large_image:String?
  
    /** 帖子的类型 */
    var type:String?
    /** 音频时长 */
    var voicetime:NSNumber?
    /** 音频路径*/
    var voiceuri:NSURL?

    /** 视频时长 */
    var videotime:NSNumber?
    
    /** 视频路径*/
    var videouri:String?

    /** 播放次数 */
    var playcount:NSNumber?
    
    var top_cmt:CommentModel?
    
    //添加额外的属性
    var cellHeight:CGFloat?
    var pictureFrame:CGRect?
    var voiceFrame:CGRect?
    var videoFrame:CGRect?
    var islarge:Bool = false
    var pictureProgress:CGFloat?
    var topCellHeight:CGFloat? {
    
        get {
        
            if cellHeight == nil {
                
                //计算cell的高度
                let textSize = CGSizeMake(ScreenWidth - 2*margin, (CGFloat)(MAXFLOAT))
                var dict = [String:AnyObject]()
                let font = UIFont.systemFontOfSize(14)
                dict = [NSFontAttributeName:font]
                //text的高度
                let textHeight = (text! as NSString).boundingRectWithSize(textSize, options: .UsesLineFragmentOrigin, attributes: dict, context: nil).size.height
                
                
                cellHeight = topheight + (CGFloat)(2 * margin) + textHeight
                if type == commonType.PictureType.rawValue {
                    
                    //图片的frame
                    let pictureFrameX = margin
                    let pictureFrameY = topheight + (CGFloat)(3 * margin) + textHeight
                    let pictureFrameW = ScreenWidth - 2 * margin
                    let pictureW = CGFloat((self.width! as NSString).floatValue)
                    let pictureH = CGFloat((self.height! as NSString).floatValue)
                    var pictureFrameH = pictureFrameW * pictureH / pictureW
                    if pictureFrameH > picture_MAXHEIGHT {
                        islarge = true
                        pictureFrameH = picture_NORMAL
                    }
                    
                    pictureFrame = CGRectMake(pictureFrameX, pictureFrameY, pictureFrameW, pictureFrameH)
                    cellHeight = cellHeight! + pictureFrameH
                }else if type == commonType.VoiceType.rawValue {
                    
                    //声音的Frame
                    let voiceX :CGFloat = margin
                    let voiceY = topheight + (CGFloat)(3 * margin) + textHeight
                    let voiceW = ScreenWidth - 2 * margin
                    let voicePictureW = CGFloat((self.width! as NSString).floatValue)
                    let voicePictureH = CGFloat((self.height! as NSString).floatValue)
                    let voiceH = voiceW * voicePictureH / voicePictureW
                    
                    voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH)
                    cellHeight = cellHeight! + voiceH + margin
                    
                }else if type == commonType.VideoType.rawValue {
                    
                    let videoX:CGFloat = margin
                    let videoY:CGFloat = topheight + (CGFloat)(3 * margin) + textHeight
                    let videoW:CGFloat = ScreenWidth - 2 * margin
                    let videoPictureW = CGFloat((self.width! as NSString).floatValue)
                    let videoPictureH = CGFloat((self.height! as NSString).floatValue)
                    let videoH = videoW * videoPictureH / videoPictureW
                    
                    videoFrame = CGRectMake(videoX, videoY, videoW, videoH)
                    cellHeight = cellHeight! + videoH + margin
                }
                
                
                // 如果有最热评论
                if ((top_cmt) != nil) {
                    let content = (top_cmt!.user?.username)! + (top_cmt!.content)!
                    
                    var dict = [String:AnyObject]()
                    let font = UIFont.systemFontOfSize(14)
                    dict = [NSFontAttributeName:font]
                    let textSize = CGSizeMake(ScreenWidth - 2*margin, (CGFloat)(MAXFLOAT))
                    let contentH = (content as NSString).boundingRectWithSize(textSize, options: .UsesLineFragmentOrigin, attributes: dict, context: nil).size.height
                    cellHeight = cellHeight! + contentH + margin
                }
                // 底部工具条的高度
                cellHeight = cellHeight! + bottomHeight + margin
            }
            
                return cellHeight
        }

    }
    


    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
       
        
        return ["top_cmt": "top_cmt[0]"]
    }
    
    //获取数据
    class func getTopCommonModel(params:NSMutableDictionary, success:(responseObject:[TopCommonModel]?, json:[String:AnyObject]?)->Void, failure:(error:NSError?)->Void) {
        
            let url = "http://api.budejie.com/api/api_open.php"
            NetWorkTools.shareNetworkTools().GET(url, parameters: params, progress: { (_) -> Void in
                
                }, success: { (_, responseObject) -> Void in
                    
                    let objArry = responseObject!["list"]
                    let  commonModelArry = TopCommonModel.mj_objectArrayWithKeyValuesArray(objArry)
                    
                    //缓存数据
                    DBManage.shareDBManage().saveEssenceDictArray(objArry as! [[String: AnyObject]], json: responseObject as! [String: AnyObject])
                    
                    success(responseObject: commonModelArry as AnyObject as?[TopCommonModel], json: responseObject! as? [String : AnyObject])
                    
                }) { (_, error) -> Void in
                    
                    failure(error: error)
            }
    }
    
    
    //更该json中返回的字段作为模型的名字
//    class  func replacedKeyFromPropertyName() -> NSDictionary {
//    
//        return ["small_image" : "image0", "large_image" : "image1", "middle_image" : "image2"]
//    }
//    + (NSDictionary *)replacedKeyFromPropertyName
//    {
//    return @{
//    @"small_image" : @"image0",
//    @"large_image" : @"image1",
//    @"middle_image" : @"image2"
//    };
  //  }

}
