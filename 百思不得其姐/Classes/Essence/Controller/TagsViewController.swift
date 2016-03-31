//
//  TagsViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/14/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SVProgressHUD

private  let TagsId = "tag"
class TagsViewController: UITableViewController {
    
    var tagsArry:NSArray =  {
    
       let tagsArry = NSArray()
        return tagsArry
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化TableView
        setupTableView()
        
        //加载数据
        loadTagsData()
    }
    
    private func loadTagsData() {
    
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Black)
        TagsModel .getTagsModel({ (responseObject) -> () in
            
            SVProgressHUD.dismiss()
            
            self.tagsArry = responseObject!
            
            self.tableView.reloadData()
            
            }) { (error) -> () in
               
                 SVProgressHUD.dismiss()
            }
    }
    
    private func setupTableView(){
    
        navigationItem.title = "推荐标签"
        tableView.registerNib(UINib(nibName: "TagsTableViewCell", bundle: nil), forCellReuseIdentifier: TagsId)
        tableView.rowHeight = 70
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundColor = GlobalBg
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagsArry.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TagsId, forIndexPath: indexPath) as! TagsTableViewCell

        cell.model = self.tagsArry[indexPath.row] as? TagsModel
        
        return cell
    }
   
}
