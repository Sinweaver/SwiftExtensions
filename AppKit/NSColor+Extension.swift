//
//  UIColor+Extension.swift
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

#if os(OSX)

import Cocoa

public extension NSColor {
    
    public class func colorWithRGBHex(_ hex: Int, withAlpha alpha: CGFloat = 1.0) -> NSColor {
        let components = (
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 08) & 0xff) / 255,
            blue: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        return NSColor(
            red: components.red,
            green: components.green,
            blue: components.blue,
            alpha: alpha)
    }
    
    public class func colorWithHexString(_ hexString: String, alpha: CGFloat = 1.0) -> NSColor {
        let hex = hexString.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask) / 255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask) / 255.0)
        let b = CGFloat(Float(Int(color) & mask) / 255.0)
        
        return NSColor(
            red: r,
            green: g,
            blue: b,
            alpha: alpha)
    }
    
    public var randomColor: NSColor {
        let r: CGFloat = CGFloat(arc4random() % 255)
        let g: CGFloat = CGFloat(arc4random() % 255)
        let b: CGFloat = CGFloat(arc4random() % 255)
        
        return NSColor(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            alpha: 1.0)
    }
    
    public var randomColor2: NSColor {
        srand48(Int(arc4random()))
        
        var red: CGFloat = 0.0;
        while (red < 0.1 || red > 0.84) {
            red = CGFloat(drand48());
        }
        
        var green: CGFloat = 0.0;
        while (green < 0.1 || green > 0.84) {
            green = CGFloat(drand48())
        }
        
        var blue: CGFloat = 0.0;
        while (blue < 0.1 || blue > 0.84) {
            blue = CGFloat(drand48())
        }
        
        return NSColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0)
    }
    
    public var redComponent: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    
    public var greenComponent: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    
    public var blueComponent: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
    
    public var alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
}

#endif
