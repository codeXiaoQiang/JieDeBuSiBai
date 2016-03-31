//
//  DBManage.swift
//  SinaWeiBo
//
//  Created by yangtao on 3/4/16.
//  Copyright © 2016 Rain YANG. All rights reserved.
//

import UIKit
//import FMDB

class DBManage: NSObject {

    private static let dbManage = DBManage()
    
    class func shareDBManage() -> DBManage {
    
        return dbManage
    }
    
    var db:FMDatabase?
    
    func openDB(DBName:String) {
    
        //创建数据库路径
        let path = DBName.docDir();
        
        //创建数据库对象
        db = FMDatabase(path: path)
        if !db!.open() {
            
            print("\(DBName)数据库打开失败")
            return
        }
        
        //创建表
        creatTable(DBName)
    }
    
    private func creatTable(DBName:String) {
        //编写sql语句
       let sql = "CREATE TABLE IF NOT EXISTS T_essence(id integer PRIMARY KEY AUTOINCREMENT, EssenceModel blob NOT NULL, AllEssence blob NOT NULL);"
        
        //执行sql语句
        if db!.executeUpdate(sql, withArgumentsInArray: nil) {
        
             print("\(DBName)数据库创建表成功"+":"+"\(DBName.docDir())")
            
        }else {
        
             print("\(DBName)数据库创建表失败")
        }
    }
    
    /**
    *  缓存精华字典数组到数据库中
    */
    func saveEssenceDictArray(modelArry:NSArray, json:NSDictionary) {
        
        for dict in modelArry {

            let modelArrydata = NSKeyedArchiver .archivedDataWithRootObject(dict)
            let jsondata = NSKeyedArchiver .archivedDataWithRootObject(json)
            let sql = "INSERT INTO T_essence (EssenceModel, AllEssence) VALUES (?,?);"
            db?.executeUpdate(sql, modelArrydata, jsondata)
        }
    }
    
  
    func cachedmodelArryWithParam() ->(modelArry:[TopCommonModel],JSON:[String:AnyObject]){
        // 创建数组缓存微博数据
        var Essencemodels = [TopCommonModel]()
        var AllEssencejson = [String:AnyObject]()
        var resultSet:FMResultSet?
 
        
        let sql = "SELECT * FROM T_essence;"
        resultSet = db?.executeQuery(sql)
        while resultSet!.next(){
        
            let data = resultSet?.objectForColumnName("EssenceModel") as! NSData
            let dict = NSKeyedUnarchiver .unarchiveObjectWithData(data) as! [String : AnyObject]
            let model = TopCommonModel.mj_objectWithKeyValues(dict)
            
            let json = resultSet?.objectForColumnName("AllEssence") as! NSData
            AllEssencejson = NSKeyedUnarchiver .unarchiveObjectWithData(json) as! [String : AnyObject]
            
            Essencemodels.append(model)
        }
        
        return (Essencemodels,AllEssencejson)
    }
    
}
