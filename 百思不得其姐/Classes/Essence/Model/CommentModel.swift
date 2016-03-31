//
//  CommentModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/21/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import MJExtension

class CommentModel: NSObject {

    /** id */
    var id:String?
    /** 音频文件的时长 */
    var voicetime:NSNumber?
    /** 音频文件的路径 */
    var voiceurl:String?
    /** 评论的文字内容 */
    var content:String?
    /** 被点赞的数量 */
    var like_count:NSNumber?
    /** 用户 */
    var user:CommentUserModel?
    
    
    class func modelfromData(dict:[String:AnyObject]) {
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    class func getCommentModel(params:NSMutableDictionary, success:(hotComments:[CommentModel]?, latestComments:[CommentModel]?, json:[String:AnyObject]?)->Void, failure:(error:NSError?)->Void) {
        
        let url = "http://api.budejie.com/api/api_open.php"
       
        NetWorkTools.shareNetworkTools().GET(url, parameters: params, progress: { (_) -> Void in
            
            }, success: { (_, responseObject) -> Void in
                
                //字典转换模型
                let dataobj = responseObject!["data"]
                 var latesArry = []
                if dataobj != nil {
                    latesArry = CommentModel.mj_objectArrayWithKeyValuesArray(dataobj)
                }
           
                
                let currentPage = params["page"] as! Int
                let hotobj = responseObject!["hot"]
                var hotArry = []
                if hotobj != nil {
                
                    if currentPage == 1 {
                        
                        hotArry = CommentModel.mj_objectArrayWithKeyValuesArray(responseObject!["hot"])
                        
                    }

                }
                
                
                
                //回调成功把模型数组传出去
                success(hotComments:hotArry as AnyObject as? [CommentModel], latestComments:latesArry as AnyObject as? [CommentModel], json: responseObject! as AnyObject as? [String : AnyObject])
                
            }) { (_, error) -> Void in
                
                  failure(error: error)
        }
    }

}
