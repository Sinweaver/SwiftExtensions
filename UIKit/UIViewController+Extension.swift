//
//  UIViewController+Extension.swift
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

public extension UIViewController {
    
    public var isVisible: Bool {
        return self.isViewLoaded && view.window != nil
    }
    
    public var isModal: Bool {
        if let index = navigationController?.viewControllers.index(of: self), index > 0 {
            return false
        }
        else if presentingViewController != nil {
            return true
        }
        else if navigationController?.presentingViewController?.presentedViewController == navigationController  {
            return true
        }
        else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        else {
            return false
        }
    }
    
    public func addController(_ controller: UIViewController, toView: UIView) {
        addChildViewController(controller)
        toView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
        
//        // Setup constraints for layout
//        controller.view.translatesAutoresizingMaskIntoConstraints = false
//        controller.view.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
//        controller.view.leftAnchor.constraint(equalTo: toView.leftAnchor).isActive = true
//        controller.view.widthAnchor.constraint(equalTo: toView.widthAnchor).isActive = true
//        controller.view.heightAnchor.constraint(equalTo: toView.heightAnchor).isActive = true
    }
}

#if os(iOS)
public extension UIViewController {
   
    public func removeBackBarButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
}
#endif

#endif
