//
//  CommonTableViewCell.swift
//  百思不得其姐
//
//  Created by yangtao on 3/30/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {
    
    //数据模型
    var item:CommonItemModel? {
        
        didSet {
            
            if let itemModel = item {
            
                //设置基本数据
                textLabel?.text  = itemModel.leftText
            
                if itemModel.isKindOfClass(CommonSwitchItem.classForCoder()) {
                    //开关
                    self.accessoryView = rightSwitch
                }else if itemModel.isKindOfClass(CommonLabelItem.classForCoder()) {
                
                    //添加子控件
                    contentView.addSubview(rightLabel)
                    rightLabel.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: textLabel!, size: CGSizeMake(ScreenWidth-80, self.height), offset: CGPointMake(80, 0))
               
                    rightLabel.text = (itemModel as! CommonLabelItem).text
                    accessoryType = .None
                }
            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: CommonTableViewCellIdentifier)

        //设置基本属性
        accessoryType = .DisclosureIndicator
        textLabel?.font = UIFont.systemFontOfSize(15)
    }
    

    //开关
    private lazy var rightSwitch:UISwitch =  {
        
        let rightSwitch = UISwitch()
        
        return rightSwitch
    }()
    
    
    //label
    private lazy var rightLabel:UILabel =  {
        
        let rightLabel = UILabel()
        rightLabel.font = UIFont.systemFontOfSize(15)
        return rightLabel
    }()

    
    
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

}
