//
//  FloatingPoint+Extension.swift
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

public extension FloatingPoint {
    
    public var abs: Self {
        return Swift.abs(self)
    }
    
    public var ceil: Self {
        return Foundation.ceil(self)
    }
    
    public var floor: Self {
        return Foundation.floor(self)
    }
    
    public var isPositive: Bool {
        return self > 0
    }
    
    public var isNegative: Bool {
        return self < 0
    }
    
    public var sqrt: Self {
        return Foundation.sqrt(self)
    }
    
    public var round: Self {
        return Foundation.round(self)
    }
    
    public func clamp (min: Self, _ max: Self) -> Self {
        return Swift.max(min, Swift.min(max, self))
    }
    
    public var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }
    
    public var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }
}

public extension FloatingPoint {
    
    public static func random(between min: Self, and max: Self) -> Self {
        let aMin = Self.minimum(min, max)
        let aMax = Self.maximum(min, max)
        let delta = aMax - aMin
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    }
    
    public static func random(inRange range: ClosedRange<Self>) -> Self {
        let delta = range.upperBound - range.lowerBound
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    }
    
    public func currencyStyleStringWithSymbol(_ currencySymbol: String?, locale: String?) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let currencySymbol = currencySymbol {
            formatter.currencySymbol = currencySymbol
        }
        
        if let locale = locale {
            formatter.locale = Locale(identifier: locale)
        }
    
        return formatter.string(from: self as! NSNumber) ?? ""
    }
    
    //    static func random(min: Float = 0, max: Float) -> Float {
    //        let diff = max - min;
    //        let rand = Float(arc4random() % (UInt32(RAND_MAX) + 1))
    //        return ((rand / Float(RAND_MAX)) * diff) + min;
    //    }
    //
    //    public static func randomBetween(min: Double, max: Double) -> Double {
    //        let delta = max - min
    //        return min + Double(arc4random_uniform(UInt32(delta)))
    //    }
    
    //    public static func randomBetween(min: Self, max: Self) -> Self {
    //        let delta = max - min
    //        return min + Self(arc4random_uniform(UInt32(delta)))
    //    }
    //
    //
    //    public static func random(between min: Self, and max: Self) -> Self {
    //        let aMin = Self.minimum(min, max)
    //        let aMax = Self.maximum(min, max)
    //        let delta = aMax - aMin
    //        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    //    }
    //
    //    public static func random(inRange range: ClosedRange<Self>) -> Self {
    //        let delta = range.upperBound - range.lowerBound
    //        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    //    }
}

