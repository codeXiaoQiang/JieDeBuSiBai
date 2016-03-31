//
//  MeTableViewCell.swift
//  百思不得其姐
//
//  Created by yangtao on 3/23/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class MeTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    
        let bgView = UIImageView()
        bgView.image = UIImage(named: "mainCellBackground")
        backgroundView = bgView
        
        textLabel!.textColor = UIColor.darkGrayColor()
        textLabel!.font = UIFont.systemFontOfSize(16)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView?.image == nil {
        
            return
        }
        imageView?.width = 30
        imageView?.height = (imageView?.width)!
        imageView?.centerY = contentView.height / 2
        textLabel!.x = CGRectGetMaxX(imageView!.frame) + 10
    }
    
    
//    override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
//        
//        frame.size.height -= 1        
//    }

}
