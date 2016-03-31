//
//  SettingsViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/30/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
class SettingsViewController: CommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setuptableView()
        setupSection1()
        setupSection2()
        addFooterView()
    }
    
    private func setuptableView() {
    
        // 设置tableView属性
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 40, 0)
    }
    
    private func  addFooterView() {
        
        let footerView = UIButton()
        footerView.addTarget(self, action: "didOut", forControlEvents: UIControlEvents.TouchUpInside)
        footerView.backgroundColor = UIColor.redColor()
        footerView.setTitle("退出当前登录", forState: UIControlState.Normal)
        footerView.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        footerView.frame = CGRectMake(10,  ScreenHeight+64+35+10, ScreenWidth-20, 35)

        tableView.addSubview(footerView)
    }
    
    func didOut() {
        
        print(__FUNCTION__)
    }
    
    private func   setupSection1() {
    
        //设置组数据
        let group = CommonSectionModel.group()
        group.sectionHead = "功能设置"
        self.groups.addObject(group)
        
        //设置行数据
        let item0 = CommonItemModel.itemWithTitle("字体大小")
        let item1 = CommonSwitchItem.itemWithTitle("摇一摇夜间模式")
        let item2 = CommonItemModel.itemWithTitle("通知设置")
        group.items = [item0,item1,item2]
    }
    
    private func   setupSection2() {
        
         //设置组数据
        let group = CommonSectionModel.group()
         group.sectionHead = "其他"
        self.groups.addObject(group)
        
         //设置行数据
        let item0 = CommonLabelItem.itemWithTitle("清除缓存")

        // 设置缓存的大小
        let caches = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last
        (caches! as NSString).stringByAppendingPathComponent("com.hackemist.SDWebImageCache.default")

        let fileSize:Int64 = (caches?.fileSize())!
        let mb = (Double)(fileSize)/(1000.0 * 1000.0)
       let size =  String(format: "%.1f", mb)
        item0.text  = "(已使用\(size)" + "MB)"
        item0.operation = {
        
            () in
          
            SVProgressHUD.showInfoWithStatus("正在清除缓存")
            // 清除缓存
            let mgr = NSFileManager.defaultManager()
            do {
            
               try mgr.removeItemAtPath(caches!)
            }catch {
                
            }
        
            // 设置subtitle
            item0.text = nil
            
            // 刷新表格
            self.tableView.reloadData()
            
            SVProgressHUD.dismiss()
        }
        let item1 = CommonItemModel.itemWithTitle("推介给朋友")
        let item2 = CommonItemModel.itemWithTitle("帮助")
        let item3 = CommonLabelItem.itemWithTitle("当前版本:")
        item3.text = "4.0"
        //item3.destVcClass = SettingsViewController.classForCoder()
        
        let item4 = CommonItemModel.itemWithTitle("关于我们")
        let item5 = CommonItemModel.itemWithTitle("设备信息")
        let item6 = CommonItemModel.itemWithTitle("隐私政策")
        let item7 = CommonItemModel.itemWithTitle("打分支持不得姐!")
        group.items = [item0,item1,item2,item3,item4,item5,item6,item7]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
