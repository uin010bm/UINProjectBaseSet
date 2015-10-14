//
//  NSDate.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation

public extension NSDate {
    
    // MARK: - private propertys
    /// Property to get date Int.
    private var components: NSDateComponents {
        return NSCalendar.currentCalendar().components([.Year, .Month, .Day, .Weekday, .Hour, .Minute, .Second], fromDate: self)
    }
    
    
    // MARK: - public propertys
    /// Get yer
    public var year: Int {
        return components.year
    }
    /// Get month
    public var month: Int {
        return components.month
    }
    /// Get day
    public var day: Int {
        return components.day
    }
    /// Get weekday
    public var weekday: Int {
        return components.weekday
    }
    /// Get hour
    public var hour: Int {
        return components.hour
    }
    /// Get minute
    public var minute: Int {
        return components.minute
    }
    /// Get second
    public var second: Int {
        return components.second
    }
    
    
    
    // MARK: - public class functions
    /// Get NSDate object with milli seconds.
    public class func getDateWithMilliSeconds(milliSec:Int64) -> NSDate {
        let ti = NSTimeInterval(milliSec / 1000)
        return NSDate(timeIntervalSince1970:ti)
    }
    
    /// Get Now Int.
    public class func getNowIntTime() -> Int64 {
        let time:Int64 = Int64(NSDate().timeIntervalSince1970) * 1000
        return time
    }
    
    
    
    // MARK: - public functions
    /**
    Get formatted date string with format string.
    
    :param: string set date format by string
    
    :returns: formatted string
    */
    public func getStringWithFormatString(string:String) -> String {
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = string
        return formatter.stringFromDate(self)
    }
    
    
    /**
    Get diff time from now.
    
    :returns: diff time interval.
    */
    public func getDiffTimeIntervalFromNow() -> NSTimeInterval {
        let now = NSDate()
        return now.timeIntervalSinceDate(self)
    }
    
    
    /**
    Get NSDate converted with timezone.
    
    :param: timezone set NSTimeZone
    
    :returns: converted NSDate
    */
    public func getNowDateWithTimezone(timezone:NSTimeZone) -> NSDate {
        let cal = NSCalendar.currentCalendar()
        let c = cal.components([NSCalendarUnit.Year, NSCalendarUnit.TimeZone, NSCalendarUnit.Day, NSCalendarUnit.Month], fromDate: self)
        let components = NSDateComponents()
        components.timeZone = timezone
        components.year = c.year
        components.month = c.month
        components.day = c.day
        return cal.dateFromComponents(components)!
    }
    
    
    /**
    Set components property's timezone.
    
    :param: timeZone setNSTimeZone
    */
    public func setComonentsTimeZone(timeZone: NSTimeZone) {
        self.components.timeZone = timeZone
    }
}