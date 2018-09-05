//
//  UINavigationController+Extension.swift
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

public extension UINavigationController {
    
    public func popViewController(_ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
    
    public func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}

#if os(iOS)
public extension UINavigationController {
    open override var shouldAutorotate: Bool {
        guard let vc = self.viewControllers.last else {
            return super.shouldAutorotate
        }
        
        return vc.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let vc = self.viewControllers.last else {
            return super.supportedInterfaceOrientations
        }
        
        return vc.supportedInterfaceOrientations
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        guard let vc = self.viewControllers.last else {
            return super.preferredInterfaceOrientationForPresentation
        }
        
        return vc.preferredInterfaceOrientationForPresentation
    }
}
#endif

#endif