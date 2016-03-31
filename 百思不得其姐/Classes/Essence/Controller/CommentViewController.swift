//
//  CommentViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/21/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import MJRefresh
import KRVideoPlayer

private  var CommentId = "comment"
class CommentViewController: UIViewController {

    private var videoController:KRVideoPlayerController?
    
    @IBOutlet weak var bottomSapce: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var commentModel:TopCommonModel?
    var page:Int = 0
    var saveTop_cmt:CommentModel?
    
    private lazy var hotCommentsArry:[CommentModel]  = {
        let hotCommentsArry = [CommentModel]()
        
        return hotCommentsArry
    }()
    
    private lazy var latestCommentsArry:[CommentModel]  = {
        let latestCommentsArry = [CommentModel]()
        
        return latestCommentsArry
    }()
   
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        
        //创建顶部cell
        setupHeader()
        
        addRefresh()

    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        // 让正在播放的视频暂停的通知
        NSNotificationCenter.defaultCenter().postNotificationName(VideoDismissDidNotification, object: self, userInfo: nil)
    }

    private func  addRefresh(){
    
        header.setRefreshingTarget(self, refreshingAction: Selector("loadNewUsers"))
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        
        footer.setRefreshingTarget(self, refreshingAction: Selector("loadMoreUsers"))
        tableView.mj_footer = footer
        tableView.mj_footer.hidden = true
    }
    
   
    func loadNewUsers() {
    
        page = 1
        let params = NSMutableDictionary(capacity: 0)
         params.setValue(page, forKey: "page")
        params.setValue("dataList", forKey: "a")
        params.setValue("comment", forKey: "c")
        params.setValue(commentModel!.id, forKey: "data_id")
        params.setValue( "1", forKey: "hot")
        CommentModel.getCommentModel(params, success: { (hotComments, latestComments, json) -> Void in
            
            
            self.hotCommentsArry = hotComments!
            self.latestCommentsArry = latestComments!
            
            self.tableView.reloadData()
            self.header.endRefreshing()
            
            // 控制footer的状态
            let total = json?["total"]!.integerValue
            if (self.latestCommentsArry.count >= total) { // 全部加载完毕
                
               
                self.footer.hidden = true
            }
            
            }) { (error) -> Void in
                  self.header.endRefreshing()
        }
    }
    
    func loadMoreUsers() {
        
        page += 1
        let params = NSMutableDictionary(capacity: 0)
        params.setValue("dataList", forKey: "a")
        params.setValue("comment", forKey: "c")
        params.setValue(page, forKey: "page")
        params.setValue(commentModel!.id, forKey: "data_id")
        let cmt = latestCommentsArry.last
        params.setValue(cmt!.id, forKey: "lastcid")
        
        CommentModel.getCommentModel(params, success: { (hotComments, latestComments, json) -> Void in

            self.latestCommentsArry = self.latestCommentsArry + latestComments!
            self.tableView.reloadData()
            
            // 控制footer的状态
            var total = 0
            if json != nil {
            
                total = json!["total"]!.integerValue
            }
            
            if (self.latestCommentsArry.count >= total) { // 全部加载完毕
           
                 self.footer.endRefreshingWithNoMoreData()
            }else {
                self.footer.endRefreshing()
            }
            
            }) { (error) -> Void in
                self.footer.endRefreshing()
        }

    }
    
    private func  setupTableView() {
    
        title = "评论";
        navigationItem.rightBarButtonItem = UIBarButtonItem.itemWithImage("comment_nav_item_share_icon" , highlightedImageNamed: "comment_nav_item_share_icon_click", title: "", target: nil, action: nil)

        //监听键盘尺寸的改变
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        // cell的高度设置
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableViewAutomaticDimension;
    
        // 背景色
        tableView.backgroundColor = GlobalBg;
    
        // 注册
        tableView.registerNib(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: CommentId)
        
        // 去掉分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
    }
    
    func keyboardWillChangeFrame(info:NSNotification) {
        // 键盘显示\隐藏完毕的frame
        let frame = info.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue
    
        // 修改底部约束
        bottomSapce.constant = ScreenHeight - frame!.origin.y
        
        // 动画时间
        let duration = info.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        // 动画
        UIView.animateWithDuration(duration!) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
      private  func setupHeader() {
        // 清空top_cmt
        if ((commentModel!.top_cmt) != nil) {
            saveTop_cmt = commentModel!.top_cmt
            commentModel!.top_cmt = nil
           commentModel?.cellHeight = nil
        }

        let header = UIView()
        let headercell = TopCommonCell .cellwithNib()
        headercell.model = commentModel
        headercell.size = CGSizeMake(ScreenWidth, (commentModel?.topCellHeight)!)
        header.addSubview(headercell)
    
        header.height = commentModel!.topCellHeight! + 10
        tableView.tableHeaderView = header
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CommentViewController:UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
        //隐藏菜单
        UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        
        let offsetY = scrollView.contentOffset.y
        let margin = (commentModel?.cellHeight)! - 64 - 64
        if offsetY >= margin {
            
            print(offsetY)
            print(margin)
            var info = NSDictionary() as [NSObject : AnyObject]
            info["key"] = commentModel?.cellHeight
            NSNotificationCenter.defaultCenter().postNotificationName(CommentScrollToBottomDidNotification, object: self, userInfo: info )
            
        }else {
            
            NSNotificationCenter.defaultCenter().postNotificationName(CommentScrollToTopDidNotification, object: self, userInfo: nil)
        }

        
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        let hotCount = hotCommentsArry.count ?? 0
        let latestCount = latestCommentsArry.count ?? 0
        
        if hotCount > 0 {// 有"最热评论" + "最新评论" 2组
            
            return 2
        }
        
        if latestCount > 0 {// 有"最新评论" 1 组
            return 1
        }
        
        return 0;
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let hotCount = hotCommentsArry.count
        let latestCount = latestCommentsArry.count
        
        // 隐藏尾部控件
        footer.hidden = (latestCount == 0)
        if (section == 0) {
            
            if hotCount > 0 {
                
                return hotCount
            }else {
                return latestCount
            }
        }
        
        // 非第0组
        return latestCount
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CommentId, forIndexPath: indexPath) as! CommentCell
        
            cell.commentModel = commentInIndexPath(indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            // 先从缓存池中找header
            let headerView = CommentHeadView.headerViewWithTableView(tableView) as! CommentHeadView
            // 设置label的数据
            let hotCount = hotCommentsArry.count
            if (section == 0) {
                headerView.title = (hotCount > 0) ? "最热评论" : "最新评论"
            } else {
                headerView.title = "最新评论"
            }
        
            return headerView;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
         let menu = UIMenuController.sharedMenuController()
        if menu.menuVisible == true {
        
            menu.setMenuVisible(false, animated: true)
        }else {
        
            //获取cell,让他成为第一响应者,cell实现响应者两个方法
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! CommentCell
            cell.selectionStyle = .None
            
            cell.becomeFirstResponder()
            
            // 显示MenuController
            let ding = UIMenuItem(title: "顶", action: "ding:")
            let replay = UIMenuItem(title: "回复", action: "replay:")
            let report = UIMenuItem(title: "举报", action: "report:")

            menu.menuItems = [ding, replay, report]
            let rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
            menu.setTargetRect(rect, inView: cell)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    func ding(dingInfo:UIMenuController) {
    
        print(__FUNCTION__)
    }
    
    func replay(replayInfo:UIMenuController) {
         print(__FUNCTION__)
    }
    
    func report(reportInfo:UIMenuController) {
         print(__FUNCTION__)
    }
    
    /**
    * 返回第section组的所有评论数组
    */
    
    func commentsInSection(section:Int) -> NSArray {
    
        if section == 0 {
        
            if hotCommentsArry.count > 0 {
               return hotCommentsArry
            }else {
                return latestCommentsArry
            }
        }
        return latestCommentsArry
    }
    
    func commentInIndexPath(indexPath:NSIndexPath) -> CommentModel {
        
        return commentsInSection(indexPath.section)[indexPath.row] as! CommentModel
    }
    
}
