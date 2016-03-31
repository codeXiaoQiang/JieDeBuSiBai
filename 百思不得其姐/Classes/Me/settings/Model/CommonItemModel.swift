//
//  CommonItemModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/30/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class CommonItemModel: NSObject {

    //行模型
    var leftText:String?
    
    /** 点击这行cell，需要调转到哪个控制器 */
    var destVcClass:AnyClass?

    /** 封装点击这行cell想做的事情 */
    var operation: (() -> ())?
    // block 只能用 copy
   // @property (nonatomic, copy) void (^operation)();
    
    //行模型初始化
    class func itemWithTitle(name:String) -> CommonItemModel{
        
        let item =  CommonItemModel()
        item.leftText = name
        
        return item
    }
}
