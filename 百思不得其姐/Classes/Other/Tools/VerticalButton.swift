//
//  VerticalButton.swift
//  百思不得其姐
//
//  Created by yangtao on 3/20/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {

    
    private func setup() {
        
        titleLabel?.textAlignment = NSTextAlignment.Center
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整图片
        imageView!.x = 0;
        imageView!.y = 0;
        imageView!.width = self.width;
        imageView!.height = self.imageView!.width;

        // 调整文字
        titleLabel!.x = 0;
        titleLabel!.y = self.imageView!.height;
        titleLabel!.width = self.width;
        titleLabel!.height = self.height - self.titleLabel!.y;

    }
}
