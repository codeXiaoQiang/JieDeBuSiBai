//
//  CommentHeadView.swift
//  百思不得其姐
//
//  Created by yangtao on 3/21/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

private let ID = "header"
class CommentHeadView: UITableViewHeaderFooterView {

    var title:String? {
    
        didSet {
            
            if let headerTitle = title {
                
                titleLabel.text = headerTitle
            }
        }
    }
    
    class func headerViewWithTableView(tableView:UITableView) -> UIView {
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ID)
        
        if header == nil {
            header = CommentHeadView()
            
        }
        return header!
    }
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: ID)
        
        contentView.backgroundColor = GlobalBg
        contentView.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private lazy var titleLabel:UILabel = {
    
            let titleLabel = UILabel()
            titleLabel.textColor = RGBColor(67, g: 67, b: 67);
            titleLabel.width = 200;
            titleLabel.x = 10;
            titleLabel.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            return titleLabel
    }()
}
