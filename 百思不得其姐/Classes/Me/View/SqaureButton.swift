//
//  SqaureButton.swift
//  百思不得其姐
//
//  Created by yangtao on 3/23/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SDWebImage

class SqaureButton: UIButton {

    var SqaureButtonModel:SqureModel? {
        
        didSet {
            
            if let model = SqaureButtonModel {
            
                setTitle(model.name, forState: UIControlState.Normal)
                // 利用SDWebImage给按钮设置image
                sd_setImageWithURL(NSURL(string: model.icon!), forState: UIControlState.Normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
    
      titleLabel!.textAlignment = NSTextAlignment.Center
        
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
   
       titleLabel!.font = UIFont.systemFontOfSize(15)
        setBackgroundImage(UIImage(named:"mainCellBackground"), forState: UIControlState.Normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整图片
        imageView!.y = height * 0.15;
        imageView!.width = width * 0.5;
        imageView!.height = imageView!.width;
        imageView!.centerX = width * 0.5;
        
        // 调整文字
        titleLabel!.x = 0;
        titleLabel!.y = CGRectGetMaxY(imageView!.frame);
        titleLabel!.width = width;
        titleLabel!.height = height - titleLabel!.y;
    }
}
