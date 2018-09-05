//
//  UIScreen+Extension.swift
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
import Foundation

public extension UIScreen {
    
    public static var screenWidth: CGFloat {
        return UIScreen.fixedScreenSize().width
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.fixedScreenSize().height
    }
    
    public static var maxScreenLength: CGFloat {
        return max(screenWidth, screenHeight)
    }
    
    public static var minScreenLength: CGFloat {
        return min(screenWidth, screenHeight)
    }
    
    public static func isRetina() -> Bool {
        return UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) &&
            UIScreen.main.scale == 2.0
    }
    
    public static func isRetinaHD() -> Bool {
        return UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) &&
            UIScreen.main.scale == 3.0
    }
    
    public static func fixedScreenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
}

#if os(iOS)
public extension UIScreen {

    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public static var screenHeightWithoutStatusBar: CGFloat {
        if UIInterfaceOrientationIsPortrait(screenOrientation) {
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        }
        else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }
}
#endif

#endif
