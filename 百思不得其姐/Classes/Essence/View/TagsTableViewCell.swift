//
//  TagsTableViewCell.swift
//  百思不得其姐
//
//  Created by yangtao on 3/14/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SDWebImage

class TagsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageListImageView: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var subNumberLabel: UILabel!

    var model:TagsModel?  {
    
        didSet {
        
            if let tagsModel = model {
            
                //图片
                self.imageListImageView.sd_setImageWithURL(NSURL(string: tagsModel.image_list!), placeholderImage: UIImage(named: "defaultUserIcon"))

                //名称
                self.themeNameLabel.text = tagsModel.theme_name

                //订阅数
                let subNumberString:String?
                let oderNumber = Int(tagsModel.sub_number!)
                if oderNumber < 10000 {
                    subNumberString = tagsModel.sub_number! + "人订阅"
                    
                }else {
                    let num = oderNumber! / (Int)(10000.0)
                    subNumberString = "\(num)万人订阅人订阅"
                }
                
                self.subNumberLabel.text = subNumberString
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        frame.origin.x = 5
        frame.size.width -= 2 * frame.origin.x;
        frame.size.height -= 1
       
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
