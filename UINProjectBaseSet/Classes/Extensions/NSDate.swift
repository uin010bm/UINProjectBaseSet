//
//  NSDate.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/13.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation


/// NSDateを拡張するExtension
public extension NSDate {
    
    // MARK: - private propertys
    
    /// 各日付データを格納するためのcomponent
    private var components: NSDateComponents {
        return NSCalendar.currentCalendar().components([.Year, .Month, .Day, .Weekday, .Hour, .Minute, .Second], fromDate: self)
    }
    
    
    // MARK: - public propertys
    
    /// componentから年を取得
    public var year: Int {
        return components.year
    }
    
    /// componentから月を取得
    public var month: Int {
        return components.month
    }
    
    /// componentから日付を取得
    public var day: Int {
        return components.day
    }
    
    /// componentから曜日のIntを取得
    public var weekday: Int {
        return components.weekday
    }
    
    /// componentから時間を取得
    public var hour: Int {
        return components.hour
    }
    
    /// componentから分を取得
    public var minute: Int {
        return components.minute
    }
    
    /// componentから秒を取得
    public var second: Int {
        return components.second
    }
    
    
    
    // MARK: - public class functions
    
    ///  UNIXミリ秒からNSDateを取得する
    ///
    ///  - parameter milliSec: UNIXミリ秒を指定
    ///
    ///  - returns: 生成されたNSDateを返却
    public class func getDateWithMilliSeconds(milliSec:Int64) -> NSDate {
        let ti = NSTimeInterval(milliSec / 1000)
        return NSDate(timeIntervalSince1970:ti)
    }
    
    
    /// 現在のUNIXミリ秒を取得
    ///
    ///  - returns: UNIXミリ秒を返却
    public class func getNowIntTime() -> Int64 {
        let time:Int64 = Int64(NSDate().timeIntervalSince1970) * 1000
        return time
    }
    
    
    
    // MARK: - public functions
    
    ///  NSDateを指定フォーマットに変換する
    ///
    ///  - parameter string: 時間表示フォーマットをString指定
    ///
    ///  - returns: フォーマット変換済みのString
    public func getStringWithFormatString(string:String) -> String {
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = string
        return formatter.stringFromDate(self)
    }
    
    
    ///  現在時間との差分をNSTimeIntervalで取得
    ///
    ///  - returns: 時間差 (NSTimeInterval)
    public func getDiffTimeIntervalFromNow() -> NSTimeInterval {
        let now = NSDate()
        return now.timeIntervalSinceDate(self)
    }
    
    
    ///  NSDateを指定TimeZoneに適応する
    ///
    ///  - parameter timezone: TimeZoneのkeyを指定
    ///
    ///  - returns: 適応後のNSDateを返却
    public func getConvertedDateWithTimezone(timezone:NSTimeZone) -> NSDate {
        let cal = NSCalendar.currentCalendar()
        let c = cal.components([NSCalendarUnit.Year, NSCalendarUnit.TimeZone, NSCalendarUnit.Day, NSCalendarUnit.Month], fromDate: self)
        let components = NSDateComponents()
        components.timeZone = timezone
        components.year = c.year
        components.month = c.month
        components.day = c.day
        return cal.dateFromComponents(components)!
    }
    
}