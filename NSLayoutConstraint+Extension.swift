//
//  NSLayoutConstraint+Extension.swift
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

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import Foundation

public extension NSLayoutConstraint {
    
    #if os(iOS) || os(tvOS)
    public class func constraintsWithFormatArray(formatArray: [String],
                                                 options: NSLayoutFormatOptions,
                                                 metrics: [String : AnyObject]?,
                                                 views: [String : Any]) -> [NSLayoutConstraint] {
        
        var constraints: [NSLayoutConstraint] = []
        
        for format : String in formatArray {
            constraints += NSLayoutConstraint.constraints(
                withVisualFormat: format, options: options, metrics: metrics, views: views)
        }
        
        return constraints;
    }
    #elseif os(OSX)
    public class func constraintsWithFormatArray(formatArray: [String],
                                                 options: NSLayoutConstraint.FormatOptions,
                                                 metrics: [String : NSNumber]?,
                                                 views: [String : Any]) -> [NSLayoutConstraint] {
        
        var constraints: [NSLayoutConstraint] = []
        
        for format : String in formatArray {
            constraints += NSLayoutConstraint.constraints(
                withVisualFormat: format, options: options, metrics: metrics, views: views)
        }
        
        return constraints;
    }
    #endif
    
    public class func constraintsCenterX(view1: Any,
                                         toItem view2: Any?,
                                         multiplier: CGFloat,
                                         constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: view1,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view2,
            attribute: .centerX,
            multiplier: multiplier,
            constant: constant)
        
        return constraint
    }
    
    public class func constraintsCenterY(view1: Any,
                                         toItem view2: Any?,
                                         multiplier: CGFloat,
                                         constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: view1,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view2,
            attribute: .centerY,
            multiplier: multiplier,
            constant: constant)
        
        return constraint
    }
}

