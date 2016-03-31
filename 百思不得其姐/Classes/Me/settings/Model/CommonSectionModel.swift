//
//  CommonSectionModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/30/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class CommonSectionModel: NSObject {

    /**用来保存行数据*/
    var items:[CommonItemModel]?
    var sectionHead:String?
    var sectionFooter:String?
    var sectionHeadView:UIView?
    var sectionFooterView:UIView?
    
    class func group() -> CommonSectionModel{
        
        let gruop = CommonSectionModel()
        return gruop
    }
}
