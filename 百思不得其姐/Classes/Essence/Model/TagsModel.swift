//
//  TagsModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/14/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class TagsModel: NSObject {
    
    /** 图片 */
    var image_list:String?
    /** 名字 */
    var theme_name:String?
    /** 订阅数 */
    var sub_number:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    class func getTagsModel(success:(responseObject:[TagsModel]?)->(), failure:(error:NSError?)->() ) {

        let url = "http://api.budejie.com/api/api_open.php"
        let params = NSMutableDictionary(capacity: 0)
        params.setValue("tag_recommend", forKey: "a")
        params.setValue("topic", forKey: "c")
        params.setValue( "sub", forKey: "action")
        
        NetWorkTools.shareNetworkTools().GET(url, parameters: params, progress: { (_) -> Void in
            
            }, success: { (_, responseObject) -> Void in
                
                var tagsModelArry = [TagsModel]()
                
                for dict:[String:AnyObject] in responseObject as! [[String:AnyObject]] {
                
                    //字典转换模型
                    let model:TagsModel = TagsModel(dict: dict)
                    
                    //把模型保存在数组中
                    tagsModelArry.append(model)
                }
                
                //回调成功把模型数组传出去
                success(responseObject: tagsModelArry)
                
            }) { (_, error) -> Void in
                
                failure(error: error)
        }
    }

}
