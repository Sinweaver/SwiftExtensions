//
//  Date+Extension.swift
//  SwiftExtensions
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Alexander Borovikov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public extension Date {
    
    public static let minutesInAWeek = 24 * 60 * 7
    
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    public var second: Int {
        return Calendar.current.component(.second, from: self)
    }

    public var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }

    public var era: Int {
        return Calendar.current.component(Calendar.Component.era, from: self)
    }
    
    public var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    public var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    public var isFuture: Bool {
        return self > Date()
    }
    
    public var isPast: Bool {
        return self < Date()
    }
    
    public var isToday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self) == format.string(from: Date())
    }
    
    public var isYesterday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        return format.string(from: self) == format.string(from: yesterDay!)
    }
    
    public var isTomorrow: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        return format.string(from: self) == format.string(from: tomorrow!)
    }
    
    public var isThisMonth: Bool {
        let today = Date()
        return self.month == today.month && self.year == today.year
    }
    
    public var isThisWeek: Bool {
        return self.minutesInBetween(Date()) <= Double(Date.minutesInAWeek)
    }
    
    public var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    public var monthAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    public var startOfDayGMT: Date {
        return Calendar.current.startOfDay(for: self).addingTimeInterval(offsetTimezone)
    }
    
    public var endOfDayGMT: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDayGMT)!
    }
    
    public var startOfDayUTC: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    public var endOfDayUTC: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: self))!
    }
    
    public var offsetTimezone : TimeInterval {
        return TimeInterval(TimeZone.current.secondsFromGMT())
    }
    
    public func currentTimeZoneDate() -> String {
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone.current
        dtf.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        return dtf.string(from: self)
    }
    
    public func daysInBetween(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/86400)
        
        return diff
    }
    
    public func hoursInBetween(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/3600)
        
        return diff
    }
    
    public func minutesInBetween(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/60)
        
        return diff
    }
    
    public func secondsInBetween(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
       
        return diff
    }
}
