//
//  Int+Extension.swift
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

public extension Int {

    public var isEven: Bool {
        return (self % 2 == 0)
    }
    
    public var isOdd: Bool {
        return (self % 2 != 0)
    }
    
    public var isPositive: Bool {
        return (self >= 0)
    }
    
    public var isNegative: Bool {
        return (self < 0)
    }
    
    public var toDouble: Double {
        return Double(self)
    }
    
    public var toFloat: Float {
        return Float(self)
    }
    
    public var digits: Int {
        if (self == 0) {
            return 1
        }
        else if(Int(fabs(Double(self))) <= LONG_MAX) {
            return Int(log10(fabs(Double(self)))) + 1
        }
        else {
            print("Out of bounds")
            return -1;
        }
    }
}

public extension Int {
    
    public static func random(within: Range<Int>) -> Int {
        let delta = within.upperBound - within.lowerBound
        return within.lowerBound + Int(arc4random_uniform(UInt32(delta)))
    }
    
    public static func random(inRange range: ClosedRange<Int>) -> Int {
        let delta = UInt32(range.upperBound - range.lowerBound + 1)
        return range.lowerBound + Int(arc4random_uniform(delta))
    }
    
    public static func random(between min: Int, and max: Int) -> Int {
        return random(inRange: min...max)
    }
    
    //    public init(randomInRange range: ClosedRange<Self>) {
    //        let delta = range.upperBound - range.lowerBound
    //        self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    //    }
    //
    //    public static func random(inRange range: ClosedRange<Self>) -> Self {
    //        let delta = range.upperBound - range.lowerBound
    //        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    //    }
}

public extension Int {
    
    public func declOfNum(titles: [String]) -> String {
        if titles.count < 3 {
            return ""
        }
        
        let cases : [Int] = [2, 0, 1, 1, 1, 2]
        
        let index = (self % 100 > 4 && self % 100 < 20) ? 2 : cases[(self % 10 < 5) ? self % 10 : 5]
        return "\(self) \(titles[index])"
    }
}

public extension Int {
    
    var years: TimeInterval {
        return 365 * self.days
    }
    
    var year: TimeInterval {
        return self.years
    }
    
    var days: TimeInterval {
        return 24 * self.hours
    }
    
    var day: TimeInterval {
        return self.days
    }
    
    var hours: TimeInterval {
        return 60 * self.minutes
    }
    
    var hour: TimeInterval {
        return self.hours
    }
    
    var minutes: TimeInterval {
        return 60 * self.seconds
    }
    
    var minute: TimeInterval {
        return self.minutes
    }
    
    var seconds: TimeInterval {
        return TimeInterval(self)
    }
    
    var second: TimeInterval {
        return self.seconds
    }
}
