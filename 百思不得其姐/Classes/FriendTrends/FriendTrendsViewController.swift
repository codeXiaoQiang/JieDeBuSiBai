//
//  FriendTrendsViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/7/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

class FriendTrendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = GlobalBg
        self.navigationItem.title = "我的关注"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWithImage("friendsRecommentIcon", highlightedImageNamed: "friendsRecommentIcon-click", target: self, action: "friendsClick")
    }
    
    @IBAction func login(sender: AnyObject) {
     
        navigationController?.presentViewController(LoginViewController(), animated: true, completion: nil)
    }
    
    func friendsClick() {
    
        self.navigationController?.pushViewController(RecommendViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

       
}
