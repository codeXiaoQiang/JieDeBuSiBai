//
//  EssenceViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/7/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

private let titleScrollViewHight:CGFloat = 35
class EssenceViewController: UIViewController {
    
    //记录选中状态
    var selectedBtn:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        setupNav()
        
        //添加子控制器
        addchildController()
        
        //添加底部的scrollView
        addContentScrollView()
     
        //添加滚动的标题条
       addtitleScrollView()
        
        //默认加载第一个
        scrollViewDidEndScrollingAnimation(contentScrollView)

    }

    
    private func addchildController() {
    
        let allController = TopCommonController()
        allController.type = commonType.AllType
        
        let PictureController = TopCommonController()
        PictureController.type = commonType.PictureType
        
        let VideoController = TopCommonController()
        VideoController.type = commonType.VideoType

        let WordController = TopCommonController()
        WordController.type = commonType.WordType

        let VoiceController = TopCommonController()
        VoiceController.type = commonType.VoiceType

        
        addChildViewController(allController)
        addChildViewController(PictureController)
        addChildViewController(VideoController)
        addChildViewController(WordController)
        addChildViewController(VoiceController)
    }
    
    //MARK:-添加底部的scrollView
    private func addContentScrollView() {

        view.addSubview(contentScrollView)
        contentScrollView.frame = view.bounds
    }
    
    private func setupNav(){
    
     let leftItem = UIBarButtonItem.itemWithImage("MainTagSubIcon", highlightedImageNamed: "MainTagSubIconClick", target: self, action: "clickTags")
        navigationItem.leftBarButtonItem = leftItem
        
    }
    
    func clickTags() {
        
        self.navigationController?.pushViewController(TagsViewController(), animated: true)
    }
    
    //MARK: - 添加滚动的标题条
    private func addtitleScrollView() {
    
        //添加titleScrollView
        view.addSubview(titleScrollView)
        titleScrollView.frame = CGRectMake(0, 64, ScreenWidth, titleScrollViewHight)
        
        //添加titleScrollView的子控件
        addTitleButton()
        
        //添加底部滚动线条
        addBottomline()
    }
    
    private func  addBottomline() {
        titleScrollView.addSubview(lineView)

        lineView.height = 2
        lineView.y = titleScrollView.height -  lineView.height
    }
    
    //MARK: - 添加titleScrollView的子控件
    private func addTitleButton() {
    
        let titleArry = ["全部", "图片","视频",  "段子", "声音"]
        
        let btnW:CGFloat = 70
        let btnH:CGFloat = titleScrollView.height
        for var i = 0; i < titleArry.count; i++ {
        
            //创建标题按钮
            let titleBtn = CustomButton()
            titleBtn.tag = i

            titleBtn.setTitle(titleArry[i], forState: UIControlState.Normal)
            titleBtn.addTarget(self, action: "titleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            
            //设置标题按钮的frame
            let btnX = (CGFloat)(i * (Int)(btnW))
            titleBtn.frame = CGRectMake(btnX, 0, btnW, btnH)

            //添加标题按钮
            titleScrollView.addSubview(titleBtn)
            
            if i == 0 {
                
                titleBtnClick(titleBtn)
                titleBtn.titleLabel?.sizeToFit()
                lineView.height = 2
                lineView.y = titleScrollView.height -  lineView.height
                self.lineView.width = (titleBtn.titleLabel?.width)!
                self.lineView.centerX = titleBtn.centerX
            }
            
        }
        
        //添加标题按钮
        let titleScrollViewcontentWith = (CGFloat)(titleArry.count * (Int)(btnW))
        titleScrollView.contentSize = CGSizeMake(titleScrollViewcontentWith, 0)
        let contentScrollViewWith = (CGFloat)(titleArry.count * (Int)(ScreenWidth))
        contentScrollView.contentSize = CGSizeMake(contentScrollViewWith, ScreenHeight)
    }
    
    func titleBtnClick(btn:UIButton) {
        
        // 让正在播放的视频暂停的通知
        NSNotificationCenter.defaultCenter().postNotificationName(VideoDismissDidNotification, object: self, userInfo: nil)
        
        selectedBtn?.selected = false
        btn.selected = true
        selectedBtn = btn

        UIView.animateWithDuration(0.25) { () -> Void in
            
            self.lineView.width = (btn.titleLabel?.width)!
            self.lineView.centerX = btn.centerX
        }
        
        // 让底部的内容scrollView滚动到对应位置
        var offset = contentScrollView.contentOffset
        offset.x = CGFloat( btn.tag * (Int)(contentScrollView.width))
        contentScrollView .setContentOffset(offset, animated: true)
    }
    
    //MARK:- 懒加载
    private lazy var titleScrollView:UIScrollView =  {
    
        let titleScrollView = UIScrollView()
        //设置titleScrollView的属性
        titleScrollView.alwaysBounceHorizontal = true
        titleScrollView.showsHorizontalScrollIndicator = false
    
        return titleScrollView
    }()
    
    private lazy var lineView:UIView =  {
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.redColor()
        return lineView
    }()
    
    private lazy var contentScrollView:UIScrollView = {
    
        let contentScrollView = UIScrollView()
        contentScrollView.delegate = self
        
         //设置contentScrollView的属性
        contentScrollView.pagingEnabled = true
        contentScrollView.alwaysBounceHorizontal = true
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.showsVerticalScrollIndicator = false

        return contentScrollView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension EssenceViewController:UIScrollViewDelegate {
    
    /**
     * scrollView结束了滚动动画以后就会调用这个方法
     */
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let width = scrollView.frame.size.width;
        let offsetX = scrollView.contentOffset.x;
        
        // 当前位置需要显示的控制器的索引
        let index = (Int)(offsetX / width);
        
        //同步显示顶部标题
           //1.1取出标题按钮
        let btn = titleScrollView.subviews[index] as! CustomButton
        btn.selected = true
        
        UIView.animateWithDuration(0.25) { () -> Void in
            
            self.lineView.centerX = btn.centerX
        }

        var titleOffsetX = btn.center.x - width/2
            //1.3左边的标题
        if titleOffsetX < 0 {
            titleOffsetX = 0
        }
        
        // 右边超出处理
        let maxTitleOffsetX = titleScrollView.contentSize.width - width
        if titleOffsetX > maxTitleOffsetX {
        
            titleOffsetX = maxTitleOffsetX
        }
        titleScrollView.setContentOffset(CGPointMake(titleOffsetX, 0), animated: true)
        
        //#waring 让其他btn变成默认的颜色
        for titleBtn in titleScrollView.subviews {
        
            if let otherBtn = titleBtn as? CustomButton {
            
                if otherBtn != btn {
                    
                    otherBtn.scale = 0.0
                }

            }
        }

        
        // 取出需要显示的控制器
        let willShowVc = childViewControllers[index] as! UITableViewController
        
        // 如果当前位置的位置已经显示过了，就直接返回
        if willShowVc.isViewLoaded() {
            return
        }
        
        willShowVc.view.x = offsetX
        willShowVc.view.y = 0
        willShowVc.view.height = view.height
        contentScrollView.addSubview(willShowVc.view)
    }
    
    /**
     * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
     */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    /**
    * 只要scrollView在滚动，就会调用
    */
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scale = scrollView.contentOffset.x / scrollView.frame.size.width
        if scale < 0 || scale > (CGFloat)(self.titleScrollView.subviews.count - 1) {
            
            return
        }
        
        // 获得需要操作的左边CustomButton
        let leftIndex:Int = (Int)(scale)
        let leftBtn = titleScrollView.subviews[leftIndex] as! CustomButton
        
        // 获得需要操作的右边CustomButton
        let rightIndex =  leftIndex + 1
        
        var rightBtn = CustomButton()
        if rightIndex != titleScrollView.subviews.count {
        
            if let btn = titleScrollView.subviews[rightIndex] as? CustomButton {
                rightBtn = btn
            }
        }
    
        // 右边比例
        let rightScale = scale - (CGFloat)(leftIndex)
        // 左边比例
        let leftScale = 1 - rightScale
        
        leftBtn.scale = leftScale
        rightBtn.scale = rightScale
    }
}
