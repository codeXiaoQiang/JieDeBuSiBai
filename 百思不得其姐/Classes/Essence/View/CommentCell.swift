//
//  CommentCell.swift
//  百思不得其姐
//
//  Created by yangtao on 3/21/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SDWebImage

class CommentCell: UITableViewCell {

    @IBOutlet weak  var profileImageView:UIImageView!
    @IBOutlet weak  var sexView:UIImageView!
    @IBOutlet weak  var contentLabel:UILabel!
    @IBOutlet weak  var usernameLabel:UILabel!
    @IBOutlet weak  var likeCountLabel:UILabel!
    @IBOutlet weak  var voiceButton:UIButton!

    
    
    
    var commentModel:CommentModel? {

        didSet {
        
            let urlString = NSURL(string: (commentModel!.user?.profile_image)!)
            
            profileImageView?.sd_setImageWithURL(urlString, placeholderImage: UIImage(named: "defaultUserIcon"), completed: { (image, _, _, _) -> Void in
                
                let placeholder = UIImage(named: "defaultUserIcon")!.circle()
                self.profileImageView?.image =  image?.circle() ?? placeholder
            })

            
            sexView.image = (commentModel!.user?.sex == "男") ? UIImage(named:"Profile_manIcon") : UIImage(named:"Profile_womanIcon")
            contentLabel.text = commentModel!.content
            usernameLabel.text = commentModel!.user?.username
            
            likeCountLabel.text = "\(commentModel!.like_count!)"
            
            if (commentModel!.voiceurl != nil) {
                
                voiceButton.hidden = false
                voiceButton.setTitle("\(commentModel!.voicetime)", forState: UIControlState.Normal)
            }else {
                  voiceButton.hidden = true
            }
            
        }
    }
    
    //为menucontrolle服务
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool{
        
        if action == "ding:" &&  action == "replay:" && action == "report:" {
        
            return true
        }else {
        
            return false
        }
        
    
    }
    
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)

        frame.size.height -= 1

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
        
    }
    
    private lazy var bgView:UIImageView = {
        
        let bgView = UIImageView()
        bgView.image = UIImage(named: "mainCellBackground")
        self.backgroundView = bgView
        return bgView
    }()
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
