//
//  TopCommonController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/15/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh
import DOUAudioStreamer

enum commonType:String {
    
    case AllType = "1"
    case VideoType = "41"
    case PictureType = "10"
    case WordType = "29"
    case VoiceType = "31"
}

class TopCommonController: UITableViewController{
    
    let audioUrlFileModel = AudioPlayModel()
    var videoURL:NSURL?
    var videoFrame:CGRect?

    
    override class func initialize() {
        TopWindow.show()
    }

    private var commonModelArry:[TopCommonModel]? {
        didSet {
          
            tableView.reloadData()
        }
    }
    
    private var numberPage:Int = 0
    private var maxtime:String?
    private var saveParams:NSMutableDictionary?
    private var lastSelectedIndex:Int?
    
    //枚举属性,
    var type:commonType?
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    //精华还是新帖
    var a:String? {
        
        get {
            return ((parentViewController?.isKindOfClass(NewViewController.classForCoder())) != nil) ? "newlist" :  "list"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "段子"
        
        setupTableView()
        //添加刷新控件
        addRefresh()
        
        // 监听tabbar点击的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tabBarSelect", name: TabBarDidSelectNotification, object: nil)
        
        
        tableView.registerNib(UINib(nibName: "TopCommonCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillDisappear(animated: Bool) {

        // 让正在播放的视频暂停的通知
        NSNotificationCenter.defaultCenter().postNotificationName(VideoDismissDidNotification, object: self, userInfo: nil)
    }
    
    func tabBarSelect() {
        
        // 如果是连续选中2次, 直接刷新
        if lastSelectedIndex == tabBarController!.selectedIndex && self.view.isShowingOnKeyWindow() {
            
               header.beginRefreshing()
        }
        // 记录这一次选中的索引
        lastSelectedIndex = tabBarController!.selectedIndex
    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setupTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        let bottom = tabBarController?.tabBar.height
        tableView.contentInset = UIEdgeInsetsMake(35+64, 0, bottom!, 0)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.backgroundColor = UIColor.clearColor()
    }
    
    func loadNewUsers(){
        
        // 结束上啦
        tableView.mj_footer.endRefreshing()
        
        let params = NSMutableDictionary(capacity: 0)
        params.setValue(a, forKey: "a")
        params.setValue("data", forKey: "c")
        params.setValue( type?.rawValue, forKey: "type")
        saveParams = params
        
        TopCommonModel.getTopCommonModel(params,success: { (responseObject, json) -> Void in
            
            if self.saveParams != params {
                return
            }
            // 存储maxtime
            let info = json!["info"] as! [String :AnyObject]
            self.maxtime = info["maxtime"] as? String
            
            self.commonModelArry = responseObject!
            
            self.tableView.mj_header.endRefreshing()
            
            self.numberPage = 0
            }) { (error) -> Void in
                
                if self.saveParams != params {
                    return
                }
                
                self.tableView.mj_header.endRefreshing()
                print(error)
        }
        
    }
    
    func loadMoreUsers() {
        // 结束下拉
        tableView.mj_header.endRefreshing()
        
        let params = NSMutableDictionary(capacity: 0)
        params.setValue(a, forKey: "a")
        params.setValue("data", forKey: "c")
        params.setValue( type?.rawValue, forKey: "type")
        ++numberPage
        params.setValue("\(numberPage)", forKey: "page")
        params.setValue(maxtime, forKey: "maxtime")
        saveParams = params
        
        TopCommonModel.getTopCommonModel(params,success: { (responseObject, json) -> Void in
            
            if self.saveParams != params {
                return
            }
            // 存储maxtime
            let info = json!["info"] as! [String :AnyObject]
            self.maxtime = info["maxtime"] as? String
            
            // 返回的新数组添加到旧的的数组中
            self.commonModelArry! += responseObject!
            
            self.tableView.mj_footer.endRefreshing()
            
            }) { (error) -> Void in
                
                if self.saveParams != params {
                    return
                }
                
                self.tableView.mj_footer.endRefreshing()
                print(error)
        }
    }
    
    private func addRefresh(){
        
        header.setRefreshingTarget(self, refreshingAction: Selector("loadNewUsers"))
        tableView.mj_header = header
        // 自动改变透明度
        self.tableView.mj_header.automaticallyChangeAlpha = true;
        tableView.mj_header.beginRefreshing()
        
        
        footer.setRefreshingTarget(self, refreshingAction: Selector("loadMoreUsers"))
        tableView.mj_footer = footer
    }
    
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.tableView.mj_footer.hidden = (commonModelArry?.count == 0);
        return commonModelArry?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = TopCommonCell.cellwithTableView(tableView) as! TopCommonCell
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TopCommonCell
        let commonModel = commonModelArry![indexPath.row]
        cell.model = commonModel
        videoURL = NSURL(string:  cell.model!.videouri!)
        
        // 设置cell所处的行号 和 所处组的总行数
        cell.setIndexPath(indexPath)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        //获取模型计算文字的高度
        let model = commonModelArry![indexPath.row]
        videoFrame = model.videoFrame

        return model.topCellHeight ?? 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = CommentViewController()
        vc.commentModel = commonModelArry![indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


