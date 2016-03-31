//
//  SqureModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/23/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import MJExtension

class SqureModel: NSObject {

    /** 图片 */
    var icon:String?

    /** 标题文字 */
    var name:String?

    /** 链接 */
    var url:String?

    class func getSqureModel(success:(squreModelArr:[SqureModel]?)->(), failure:(error:NSError?) -> ()) {
    
        let url = "http://api.budejie.com/api/api_open.php"
        let params = NSMutableDictionary(capacity: 0)
        params.setValue("square", forKey: "a")
        params.setValue("topic", forKey: "c")
    
        NetWorkTools.shareNetworkTools().GET(url, parameters: params, progress: { (_) -> Void in
            
            }, success: { (_, responseObject) -> Void in
            
              let modelArry = SqureModel.mj_objectArrayWithKeyValuesArray(responseObject!["square_list"]) as AnyObject as! [SqureModel]
                
                success(squreModelArr:modelArry)
                
            }) { (_, error) -> Void in
           
                failure(error:error)
        }
    }
}
