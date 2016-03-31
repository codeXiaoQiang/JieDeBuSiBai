//
//  CommonTableViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/30/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

let CommonTableViewCellIdentifier = "CommonTableViewCell"
class CommonTableViewController: UITableViewController {


    init () {
    
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册cell
        tableView.registerClass(CommonTableViewCell.self, forCellReuseIdentifier: CommonTableViewCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return groups.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let group = groups[section] as! CommonSectionModel
        
        return (group.items?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CommonTableViewCellIdentifier, forIndexPath: indexPath) as! CommonTableViewCell

        //设置数据
        let group = groups[indexPath.section] as! CommonSectionModel
        let item = group.items![indexPath.row]
        cell.item = item
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let group = groups[indexPath.section] as! CommonSectionModel
        let item = group.items![indexPath.row]
        
        // 2.判断有无需要跳转的控制器
        if (item.destVcClass != nil) {

            let destVc =  (item.destVcClass as! UIViewController.Type).init()
            destVc.title = item.leftText
            navigationController?.pushViewController(destVc, animated: true)
        }
        
        // 3.判断有无想执行的操作
        if (item.operation != nil) {
             item.operation!()
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
         let group = groups[section] as! CommonSectionModel
        return group.sectionHead
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        let group = groups[section] as! CommonSectionModel
        return group.sectionFooter
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let group = groups[section] as! CommonSectionModel
        return group.sectionHeadView
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let group = groups[section] as! CommonSectionModel
        return group.sectionFooterView
    }
    
    lazy var groups:NSMutableArray = {
    
        let groups = NSMutableArray(capacity: 0)
        return groups
    }()
    
}
