//
//  RecommendViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/10/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh

private let LeftCellIdentifier = "LeftCell"
private let RightCellIdentifier = "RightCell"
class RecommendViewController: UIViewController {

    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    /**
     左边模型数字
     */
    private lazy var leftModleArry:[CategoryModel] = {
        let leftModleArry = [CategoryModel]()
        
        return leftModleArry
    }()
    
    /**
      右边模型数字
     */
    private lazy var rightModleArry:[UserModel] = {
        let rightModleArry = [UserModel]()
        
        return rightModleArry
    }()
    
    var categoryId:String?
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "推荐关注";
        
        //初始化tableView
        setupTableView()
        
        //加载数据
        addLeftData()
        
        //添加上拉加载更多与下拉刷新控件
        addRefresh()
    }
    
    private func selectedCategoryModel() -> CategoryModel {
        
        return self.leftModleArry[(leftTableView.indexPathForSelectedRow?.row)!]
    }

   private func addRefresh(){
    
        header.setRefreshingTarget(self, refreshingAction: Selector("loadNewUsers"))
        rightTableView.mj_header = header
    
        footer.setRefreshingTarget(self, refreshingAction: Selector("loadMoreUsers"))
        rightTableView.mj_footer = footer
    }
    
    func loadMoreUsers() {
    
        let model = selectedCategoryModel()
        categoryId = model.id
        
        // 设置当前页码
       ++model.currentPage
        
        UserModel.getUserModel(model, success: { (responseObject) -> () in

            // 添加到当前类别对应的用户数组中
            model.userArry =  model.userArry + responseObject!

            // 不是最后一次请求
           if self.categoryId != model.id {
                
                return
            }
            // 刷新右边的表格
            self.rightTableView.reloadData()
            
            // 让底部控件结束刷新
            self.checkFooterState()

            }, failure: { (error) -> () in
                print(error)
                
                // 防止用户连续点击请求数据的问题
                if self.categoryId != model.id {
                    
                    return
                }
                // 提醒
                SVProgressHUD.showErrorWithStatus("加载用户数据失败")
                // 结束刷新
                self.rightTableView.mj_footer.endRefreshing()
        })
    }
    
    func loadNewUsers() {
    
        let model = selectedCategoryModel()

        //防止用户连续点击
        categoryId = model.id;
        
        // 设置当前页码为1,默认加载第一页
        model.currentPage = 1;
        
        UserModel.getUserModel(model, success: { (responseObject) -> () in
            // 清除所有旧数据
            model.userArry.removeAll()
            
            // 添加到当前类别对应的用户数组中
            model.userArry =  model.userArry + responseObject!
            
            // 防止用户连续点击请求数据的问题
            if self.categoryId != model.id {
            
                return
            }
            
            // 刷新右边的表格
            self.rightTableView.reloadData()
            
            // 结束刷新
             self.rightTableView.mj_header.endRefreshing()
            
            // 让底部控件结束刷新
            self.checkFooterState()
            
            }, failure: { (error) -> () in
                print(error)
                
                // 防止用户连续点击请求数据的问题
                if self.categoryId != model.id {
                    
                    return
                }
                // 提醒
                SVProgressHUD.showErrorWithStatus("加载用户数据失败")
                // 结束刷新
                self.rightTableView.mj_header.endRefreshing()
            })
    }
    
   private func checkFooterState() {
    
        let model = selectedCategoryModel()
        
        // 每次刷新右边数据时, 都控制footer显示或者隐藏
        footer.hidden = (model.userArry.count == 0);
        
        // 让底部控件结束刷新
        if  model.userArry.count == model.total {
            
            self.footer.endRefreshingWithNoMoreData()
        }else {
            self.rightTableView.mj_footer.endRefreshing()
        }
    
    }
    
    private func addLeftData(){
        
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Black)
        CategoryModel.getCategoryModel({ (responseObject) -> () in
            
            SVProgressHUD.dismiss()
            //成功的回调
            self.leftModleArry = responseObject!
            
            //刷新表格
            self.leftTableView .reloadData()
            
            //选中第一行
              self.leftTableView.selectRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Top)
            
            // 让用户表格进入下拉刷新状态获取右边第一个数据
            self.rightTableView.mj_header.beginRefreshing()
            
            }) { (error) -> () in
               SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    private func setupTableView(){
        leftTableView.backgroundColor = GlobalBg
        leftTableView.registerNib(UINib(nibName: "LeftTableViewCell", bundle: nil), forCellReuseIdentifier: LeftCellIdentifier)
        
        rightTableView.backgroundColor = GlobalBg
        rightTableView.registerNib(UINib(nibName: "RightTableViewCell", bundle: nil), forCellReuseIdentifier: RightCellIdentifier)
        
        automaticallyAdjustsScrollViewInsets = false
        leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0)
        rightTableView.contentInset = leftTableView.contentInset
        rightTableView.rowHeight = 60;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}

extension RecommendViewController:UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if tableView == leftTableView {
            
             return self.leftModleArry.count ?? 0
        }else {
            
            // 获得左边选中的行号
            let index = leftTableView.indexPathForSelectedRow?.row
            if index == nil {
                
                return 0
            }else {
            
                let model = selectedCategoryModel()
                 return  model.userArry.count ?? 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            
            //获取cell
            let cell = tableView.dequeueReusableCellWithIdentifier(LeftCellIdentifier, forIndexPath: indexPath) as! LeftTableViewCell
            
            //拿到数据
            let model = self.leftModleArry[indexPath.row]
            cell.leftModel = model
            
            //返回cell
            return cell

        }else {
            
            //获取cell
            let cell = tableView.dequeueReusableCellWithIdentifier(RightCellIdentifier, forIndexPath: indexPath) as! RightTableViewCell
            
            
            //tableView选中的左边行号
            let model = selectedCategoryModel()
            
            //从左边的模型中拿到右边数据
            cell.rightModel = model.userArry[indexPath.row]
            
            //监听右边按钮点击
            cell.cellDelegate = self
            //返回cell
            return cell

        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == leftTableView {
            
            let categoryModel = self.leftModleArry[indexPath.row]
            if (categoryModel.userArry.count > 0) {//如果已经加载过数据
            
                self.rightTableView.reloadData()
            }else {
                
                self.rightTableView.reloadData()
                
                self.rightTableView.mj_header.beginRefreshing()
            }
            
        }
        
    }
}

extension RecommendViewController:RightTableViewCellDelegate {
    
    func didFollowButton(rightcell: RightTableViewCell) {
        
        print("__FUNCTION__")
    }
}
