//
//  NSDate+Extension.swift
//  百思不得其姐
//
//  Created by yangtao on 3/17/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit

extension NSDate {

    func deltaFrom(from:NSDate)-> NSDateComponents {
    
        // 日历
        let calendar = NSCalendar.currentCalendar()
    
        // 比较时间
        return calendar.components(NSCalendarUnit([.Day, .Month, .Year, .Hour, .Minute, .Second]), fromDate: from, toDate: self, options: NSCalendarOptions(rawValue: 0))
    }
    
    func isThisYear() -> Bool {
        
        // 日历
        let calendar = NSCalendar.currentCalendar()
        
        let nowYear = calendar.component(NSCalendarUnit.Year, fromDate: NSDate())
              let selfYear = calendar.component(NSCalendarUnit.Year, fromDate: self)
        
        return nowYear == selfYear;
    }
    
    func isToday() -> Bool {
    
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"

        let nowString = fmt.stringFromDate(NSDate())
        let selfString = fmt.stringFromDate(self)
        
        if nowString == selfString {
            
            return true
        }else {
            
            return false
        }
    }
    
    func isYesterday()-> Bool {
        
        // 日期格式化类
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"

        let nowDatestring = fmt.stringFromDate(NSDate())
        let selfDateString = fmt.stringFromDate(self)
        let nowDate  = fmt.dateFromString(nowDatestring)
        let selfDate = fmt.dateFromString(selfDateString)
        
        let calendar = NSCalendar.currentCalendar()
        let cmps =  calendar.components(NSCalendarUnit([.Day, .Month, .Year]), fromDate: selfDate!, toDate: nowDate!, options: NSCalendarOptions(rawValue: 0))

        return cmps.year == 0
            && cmps.month == 0
            && cmps.day == 1;

    }
}