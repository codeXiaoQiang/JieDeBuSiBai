//
//  CategoryModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/10/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import AFNetworking
class CategoryModel: NSObject {

    /** id */
    var id:String?
    /** 总数 */
    var count:String?
    /** 名字 */
    var name:String?
    
    //用来保存类别对应的UserModel
    var userArry:[UserModel] = {
        
        let userArry = [UserModel]()
        return userArry
    }()
    var total:NSNumber?
    
    var currentPage:Int = 0
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    //重现该方法的目的是为了防止，返回的数据与模型的属性不匹配导致程序崩溃
    //是否缺少成员属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
       // print(key)
    }
    
    class func getCategoryModel(success:(responseObject:[CategoryModel]?)->(), failure:(error:NSError?)->() ) {
        let url = "http://api.budejie.com/api/api_open.php"
        let params = NSMutableDictionary(capacity: 0)
        params.setValue("category", forKey: "a")
        params.setValue("subscribe", forKey: "c")
        
        NetWorkTools.shareNetworkTools().GET(url, parameters: params, progress: { (_) -> Void in
            
            }, success: { (_, responseObject) -> Void in
   
                print(responseObject)
                let arry = responseObject!["list"] as! [[String: AnyObject]]
                
                var categoryModelArry = [CategoryModel]()
                for dict:[String:AnyObject] in arry {
                    //字典转换模型
                    let model:CategoryModel = CategoryModel(dict: dict)
                    
                    //把模型保存在数组中
                    categoryModelArry.append(model)
                }
                //回调成功把模型数组传出去
               success(responseObject: categoryModelArry)
                
                
            }) { (_, error) -> Void in
            
                failure(error: error)
        }
    }
}
