//
//  CommonLabelItem.swift
//  百思不得其姐
//
//  Created by yangtao on 3/30/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class CommonLabelItem: CommonItemModel {

    var text:String?
    //行模型初始化
    override  class func itemWithTitle(name:String) -> CommonLabelItem{
        
        let item =  CommonLabelItem()
        item.leftText = name
        
        return item
    }
}
