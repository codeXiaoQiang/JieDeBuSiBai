//
//  MeViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/7/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
private let MeId = "me"
class MeViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()

        setupTableView()
    }
    
    private func setupNav() {
    
        // 设置导航栏标题
        navigationItem.title = "我的";
        
        // 设置导航栏右边的按钮
        let settingItem = UIBarButtonItem.itemWithImage("mine-setting-icon", highlightedImageNamed: "mine-setting-icon-click", target: self, action: "settingClick")
        
         let moonItem = UIBarButtonItem.itemWithImage("mine-moon-icon" , highlightedImageNamed: "mine-moon-icon-click", target: self, action: "moonClick")
        navigationItem.rightBarButtonItems = [settingItem, moonItem]
    }
    
    
    func settingClick() {
        
        let settingsVc = SettingsViewController()
        navigationController?.pushViewController(settingsVc, animated: true)
    }
    
    private func  setupTableView(){
        
        // 设置背景色
        tableView.backgroundColor = GlobalBg
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.registerClass(MeTableViewCell.classForCoder(), forCellReuseIdentifier: MeId)
        // 调整header和footer
       tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 10

        // 调整inset
        tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0)
        
        // 设置footerView
       tableView.tableFooterView = FooterView()

    }
    
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(MeId, forIndexPath: indexPath) as! MeTableViewCell
        
        if indexPath.section == 0 {
        
            cell.imageView?.image = UIImage(named: "mine_icon_nearby")
            cell.textLabel?.text = "登录/注册"
        }else {
            cell.textLabel?.text = "离线下载"
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
