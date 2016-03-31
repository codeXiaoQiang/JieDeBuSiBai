//
//  LeftTableViewCell.swift
//  百思不得其姐
//
//  Created by yangtao on 3/11/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedIndicator: UIView!
    
    var leftModel:CategoryModel? {
    
        didSet {
            
            if let model = leftModel{
                
                textLabel?.text = model.name
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = GlobalBg
        selectedIndicator.backgroundColor = RGBColor(219, g: 21, b: 26)
        textLabel?.font = UIFont.systemFontOfSize(15)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       textLabel?.frame.origin.y = 2
        //调整label的尺寸
       textLabel?.frame.size.height = contentView.frame.size.height -  2*(self.textLabel?.frame.origin.y)!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectedIndicator.hidden = !selected
        textLabel?.textColor = selected ? selectedIndicator.backgroundColor:
        RGBColor(78, g: 78, b: 78)
    }
    
}
