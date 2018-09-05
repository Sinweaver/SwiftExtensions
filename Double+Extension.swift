//
//  Double+Extension.swift
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

public extension Double {
    
    public var abs: Double {
        return Swift.abs(self)
    }
    
    public var ceil: Double {
        return Foundation.ceil(self)
    }
    
    public var floor: Double {
        return Foundation.floor(self)
    }
    
    public var isPositive: Bool {
        return self > 0
    }
    
    public var isNegative: Bool {
        return self < 0
    }
    
    public var sqrt: Double {
        return Foundation.sqrt(self)
    }
    
    public var round: Double {
        return Foundation.round(self)
    }
    
    public func clamp (min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    
    public var degreesToRadians: Double {
        return Double.pi * self / Double(180)
    }
    
    public var radiansToDegrees: Double {
        return self * Double(180) / Double.pi
    }
}
