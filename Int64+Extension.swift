//
//  Int64+Extension.swift
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

public extension Int64 {
    
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

public extension Int64 {

}
