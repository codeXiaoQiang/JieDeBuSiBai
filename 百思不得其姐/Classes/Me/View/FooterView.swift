//
//  FooterView.swift
//  百思不得其姐
//
//  Created by yangtao on 3/23/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class FooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
       //backgroundColor = UIColor.clearColor()
        SqureModel.getSqureModel({ (squreModelArr) -> () in
            
                self.createSquares(squreModelArr!)
            
            }) { (error) -> () in
                
                print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func createSquares(sqaures:[SqureModel]) {
        
        // 一行最多4列
        let maxCols = 4
        
        // 宽度和高度
        let buttonW :CGFloat = ScreenWidth / (CGFloat)(maxCols)
        let buttonH :CGFloat = buttonW
        
        for var i = 0; i < sqaures.count; i++  {
            // 创建按钮
            let button = SqaureButton(type: .Custom)
            // 监听点击
            button.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)

            // 传递模型
            button.SqaureButtonModel = sqaures[i];
           self.addSubview(button)
            
            // 计算frame
            let row:Int = i / maxCols
            let  col:Int = i % maxCols
            
            button.x = (CGFloat)(col) * buttonW
            button.y = (CGFloat)(row) * buttonH
            button.width = buttonW
            button.height = buttonH
            
            // 设置footer的高度
            //self.height = CGRectGetMaxY(button.frame)
        }
        
        
        // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
        let rows = (sqaures.count + maxCols - 1) / maxCols
        print("rowsrowsrowsv===\(rows)")
        // 计算footer的高度
        self.height = (CGFloat)(rows) * buttonH
        
        // 重新设置footerView
        let tableView = self.superview as!  UITableView
        tableView.tableFooterView = self

        // 重绘
        setNeedsDisplay()
    }
    
    func buttonClick(button:SqaureButton) {

        if !button.SqaureButtonModel!.url!.hasPrefix("http") {
        
            return
        }
        
        let web = SqureWebViewController()
        if let url = button.SqaureButtonModel?.url {
            
            web.webUrl = url
        }
        if let vctitle = button.SqaureButtonModel?.name {
        
             web.title = vctitle
        }
       
        let tabBarVc = UIApplication.sharedApplication().keyWindow?.rootViewController as! RTTabBarController
        let navVc =  tabBarVc.selectedViewController as! RTNavigationController
        navVc.pushViewController(web, animated: true)
    }
    
}
