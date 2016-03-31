//
//  ProgressView.swift
//  百思不得其姐
//
//  Created by yangtao on 3/18/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import DACircularProgress
class ProgressView: DALabeledCircularProgressView {

    override func awakeFromNib() {
        roundedCorners = 2
        progressLabel.textColor = UIColor.whiteColor()
    }
    
    override func setProgress(progress: CGFloat, animated: Bool) {
        super.setProgress(progress, animated: animated)
        
        let text = "\(progress * 100)" + "%"
        progressLabel.text = text.stringByReplacingOccurrencesOfString("-" , withString: "")
    }
    
}
