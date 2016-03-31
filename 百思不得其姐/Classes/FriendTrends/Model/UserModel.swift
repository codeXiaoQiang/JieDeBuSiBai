//
//  UserModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/10/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    /** 头像 */
     var header:String?
    /** 粉丝数(有多少人关注这个用户) */
     var fans_count:String?
    /** 昵称 */
     var screen_name:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
       
    }
    
    class func getUserModel(model:CategoryModel, success:(responseObject:[UserModel]?)->(), failure:(error:NSError?)->() ) {
        let url = "http://api.budejie.com/api/api_open.php"
        let params = NSMutableDictionary(capacity: 0)
        params.setValue("list", forKey: "a")
        params.setValue("subscribe", forKey: "c")
        params.setValue( model.id, forKey: "category_id")
        params.setValue("\(model.currentPage)", forKey: "page")
       
       // print("model.currentPage == \(model.currentPage)")
        
        NetWorkTools.shareNetworkTools().GET(url, parameters: params, progress: { (_) -> Void in
      
            }, success: { (_, responseObject) -> Void in
              
                print(responseObject)
                let arry = responseObject!["list"] as! [[String: AnyObject]]
                model.total = responseObject!["total"] as? NSNumber
           
                
                var userModelArry = [UserModel]()
                for dict:[String:AnyObject] in arry {
                    //字典转换模型
                    let model:UserModel = UserModel(dict: dict)
                    
                    //把模型保存在数组中
                    userModelArry.append(model)
                }
                //回调成功把模型数组传出去
                success(responseObject: userModelArry)
                
                
            }) { (_, error) -> Void in
                
                failure(error: error)
        }
    }
    
}
