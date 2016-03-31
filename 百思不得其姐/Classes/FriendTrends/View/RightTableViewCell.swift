//
//  RightTableViewCell.swift
//  百思不得其姐
//
//  Created by yangtao on 3/11/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SDWebImage

protocol RightTableViewCellDelegate:NSObjectProtocol {
 
    func didFollowButton(rightcell:RightTableViewCell)
    
}

class RightTableViewCell: UITableViewCell {

    @IBOutlet weak var headImageView: RadiusView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    weak var cellDelegate:RightTableViewCellDelegate?
    
    var rightModel:UserModel? {
        didSet {
            if let model = rightModel {
                
                let url = NSURL(string: model.header!)
                headImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "defaultUserIcon"))
                nameLabel.text = model.screen_name
                detailLabel.text = model.fans_count! + "人关注"
               
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        checkButton.setTitle("关注", forState: UIControlState.Normal)
        checkButton.setTitleColor(UIColor.redColor(),forState: UIControlState.Normal)
        checkButton.addTarget(self, action: "didFollow", forControlEvents: UIControlEvents.TouchUpInside)
    }

    func didFollow() {
        
        cellDelegate?.didFollowButton(self)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
}
