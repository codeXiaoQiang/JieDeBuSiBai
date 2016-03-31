
//
//  AppDelegate.swift
//  百思不得其姐
//
//  Created by yangtao on 3/7/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //MARK:-添加数据缓存功能
       // DBManage.shareDBManage().openDB("baisi.sqlite")
       
        //让系统去管理状态栏
         UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        let tabbarVc =  RTTabBarController()
        tabbarVc.delegate = self
        window = UIWindow()
        window?.backgroundColor = UIColor.whiteColor()
        window?.frame = UIScreen.mainScreen().bounds
        window?.rootViewController = tabbarVc
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        

        NSNotificationCenter.defaultCenter().postNotificationName(TabBarDidSelectNotification, object: nil, userInfo: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}


