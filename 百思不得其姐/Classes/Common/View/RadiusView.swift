//
//  RadiusView.swift
//  百思不得其姐
//
//  Created by yangtao on 3/11/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class RadiusView: UIImageView {

    //从xib中加载
     override func awakeFromNib() {

       layer.masksToBounds = true;
        clipsToBounds = true;
        layer.shouldRasterize = true;
        layer.rasterizationScale = UIScreen.mainScreen().scale
        layer.cornerRadius = frame.size.width/2;
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.size.width/2;
    }
   
}
