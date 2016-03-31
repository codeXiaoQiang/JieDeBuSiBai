//
//  String+Extension.swift
//  SinaWeiBo
//
//  Created by yangtao on 3/4/16.
//  Copyright © 2016 Rain YANG. All rights reserved.
//

import UIKit

extension String {

    /**
    *  将当前的字符串拼接到document后面
    */
    func docDir() -> String {
        let documents = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        let path = documents.stringByAppendingPathComponent((self as NSString).lastPathComponent)
        
        return path
    }
    
    /**
     *  将当前的字符串拼接到dcache后面
     */

    func cacheDir() -> String {
        
        let documents = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        let path = documents.stringByAppendingPathComponent((self as NSString).lastPathComponent)
        
        return path
    }
    
    /**
     *  将当前的字符串拼接到temp后面
     */
    
    func tempDir() -> String {
        
        let documents = NSTemporaryDirectory() as NSString
        let path = documents.stringByAppendingPathComponent((self as NSString).lastPathComponent)
        
        return path
    }
    
    
    func fileSize() -> (Int64) {
        
        // 1.文件管理者
        let mgr = NSFileManager.defaultManager()

        // 2.判断file是否存在
        var isDirectory:ObjCBool = ObjCBool(false)
        let fileExists:Bool = mgr.fileExistsAtPath(self, isDirectory: &isDirectory)

        // 文件\文件夹不存在
        if fileExists == false {
        
            return 0
        }
        
        // 3.判断file是否为文件夹
        if isDirectory { // 是文件夹
            
            var totalSize:Int64 = 0
            do{
                let subpaths = try mgr.contentsOfDirectoryAtPath(self)
                for subpath:String in subpaths {
                
                    let fullSubpath = (self as NSString).stringByAppendingPathComponent(subpath)
                    totalSize += fullSubpath.fileSize()
                }

            }catch{
            
                print(error)
            }
            
            return totalSize
           
        }else{ // 不是文件夹, 文件
            // 直接计算当前文件的尺寸
            
            var attr = NSDictionary() as! [String : AnyObject]
            do{
            
                 attr = try mgr.attributesOfItemAtPath(self)
              
                
            }catch{
                    print(error)
            }
            
            return (attr[NSFileSize]?.longLongValue)!
        }
    }
}
    

