//
//  NetWorkTools.swift
//  百思不得其姐
//
//  Created by yangtao on 3/17/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import AFNetworking
class NetWorkTools: AFHTTPSessionManager {

    static let tools:NetWorkTools = {
        let t = NetWorkTools()
        
        // 设置AFN能够接收得数据类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as! Set<String>
        return t
    }()
    
    // 获取单粒的方法
    class func shareNetworkTools() -> NetWorkTools {
        return tools
    }

}
