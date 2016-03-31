//
//  CheckPictureController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/19/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import SVProgressHUD
class CheckPictureController: UIViewController {
    
    var pictureModel:TopCommonModel?
    
    init (model: TopCommonModel?) {
    
        super.init(nibName: nil, bundle: nil)
        pictureModel = model
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func back(sender: AnyObject) {
        close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //出事化UIScrollView
        setUpScrollView()
        
        //添加图片
        showPicture()
        
        //添加按钮
       addButton()
     
    }
    
    private func addButton() {
    
          view.addSubview(backBtn)
            view.addSubview(forwardBtn)
          view.addSubview(saveBtn)
        
        backBtn.xmg_AlignInner(type: .TopLeft, referView: CheckpictureScrollView, size: nil, offset: CGPointMake(0, 40))
        forwardBtn.xmg_AlignInner(type: .BottomRight , referView: CheckpictureScrollView, size: CGSizeMake(40, 20), offset: CGPointMake(-10, -10))

        saveBtn.xmg_AlignInner(type: .BottomRight, referView: forwardBtn, size: CGSizeMake(40, 20), offset: CGPointMake(-70, 0))

    }
    
    private func showPicture() {
    
        CheckpictureScrollView.addSubview(showpictureView)
        
        // 4.监听图片的点击
        showpictureView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "close")
        showpictureView.addGestureRecognizer(tap)
        
        //布局showpictureView
        let imageW = CGFloat((pictureModel!.width! as NSString).floatValue)
        let imageH = CGFloat((pictureModel!.height! as NSString).floatValue)
        let pictureW = ScreenWidth
        let pictureH = ScreenWidth * imageH / imageW
        if pictureH > ScreenHeight {
            
            CheckpictureScrollView.contentSize = CGSizeMake(0, pictureH)
            showpictureView.frame = CGRectMake(0, 0, ScreenWidth, pictureH)
        }else {
            //据中显示
            showpictureView.size = CGSizeMake(pictureW, pictureH)
            showpictureView.centerY = ScreenHeight*0.5
            
        }
        
        //图片下载
        let urlString = NSURL(string: (pictureModel?.image1)!)
        showpictureView.sd_setImageWithURL(urlString)
    }
    
  
    private func setUpScrollView() {
        
        view.addSubview(CheckpictureScrollView)
        CheckpictureScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        CheckpictureScrollView.showsVerticalScrollIndicator = false
        CheckpictureScrollView.showsHorizontalScrollIndicator = false
    }
    
    func close() {
        
         dismissViewControllerAnimated(true, completion: nil)
    }

       
    func save() {
        
        let image = showpictureView.image
        UIImageWriteToSavedPhotosAlbum(image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo:AnyObject){
        if error != nil
        {
            SVProgressHUD.showErrorWithStatus("保存失败")
            SVProgressHUD.setDefaultMaskType(.Black)
        }else
        {
            SVProgressHUD.showSuccessWithStatus("保存成功")
            SVProgressHUD.setDefaultMaskType(.Black)
        }
    }

    
    func forward() {
        
    }
    
    private lazy var backBtn:UIButton = {
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "show_image_back_icon"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
        return backBtn
    }()
    
    private lazy var forwardBtn:UIButton = {
        
        let closeBtn = UIButton()
        closeBtn.setTitle("转发", forState: UIControlState.Normal)
        closeBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        closeBtn.addTarget(self, action: "forward", forControlEvents: UIControlEvents.TouchUpInside)
        return closeBtn
    }()
    
    private lazy var saveBtn:UIButton = {
        
        let saveBtn = UIButton()
        saveBtn.setTitle("保存", forState: UIControlState.Normal)
        saveBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        saveBtn.addTarget(self, action: "save", forControlEvents: UIControlEvents.TouchUpInside)
        return saveBtn
    }()

    
    private lazy var CheckpictureScrollView:UIScrollView = {
        
        let CheckpictureScrollView = UIScrollView()
        return CheckpictureScrollView
    }()
    
    private lazy var showpictureView:UIImageView = {
        
       let showpictureView = UIImageView()
        return showpictureView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
