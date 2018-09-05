//
//  UIApplication+Extension.swift
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

public extension UIApplication {
    
    public static var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    public static var buildVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? ""
    }
    
    public static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    public static var bundleName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
    
    public static var iOSVersion: String {
        return UIDevice.current.systemVersion
    }
    
    public static var appDisplayName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        }
        else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        
        return nil
    }
    
    public func isDebugBuild() -> Bool {
        let dic = ProcessInfo.processInfo.environment
        if dic["DEBUG_BUILD"] != nil {
            return true
        }
        return false
    }
    
    public static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    public static var isRelease: Bool {
        #if DEBUG
        return false
        #else
        return true
        #endif
    }
    
    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    public static var isDevice: Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        return true
        #endif
    }
    
    public static var isInTestFlight: Bool {
        return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }
    
    public static var currentRegion: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
}

public extension UIApplication {
    
    public static var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }
    
    public class func topViewController(controller: UIViewController? =
        UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
    
    public static func changeRootViewController(_ rootViewController: UIViewController,
                                                animated: Bool = true,
                                                from: UIViewController? = nil,
                                                completion: ((Bool) -> Void)? = nil) {
        
        let window = UIApplication.shared.keyWindow ?? UIApplication.shared.delegate?.window ?? nil
        if let window = window, animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = rootViewController
                window.makeKeyAndVisible()
                UIView.setAnimationsEnabled(oldState)
            }, completion: completion)
        }
        else {
            window?.rootViewController = rootViewController
        }
    }
    
    public static func changeRootViewControllerAfterDismiss(_ from: UIViewController? = nil,
                                                            to: UIViewController,
                                                            completion: ((Bool) -> Void)? = nil) {
        
        if let presenting = from?.presentingViewController {
            presenting.view.alpha = 0
            from?.dismiss(animated: false, completion: {
                changeRootViewController(to, completion: completion)
            })
        }
        else {
            changeRootViewController(to, completion: completion)
        }
    }
}

public extension UIApplication {
    
    public func openURL(_ url: String, completion: @escaping (Bool) -> ()) {
        guard let link = URL(string: url) else { return }
        
        if #available(iOS 10.0, tvOS 10.0, *) {
            UIApplication.shared.open(link, options: [:], completionHandler: completion)
        }
        else {
            UIApplication.shared.openURL(link)
        }
    }
}

#if os(iOS)
public extension UIApplication {
    
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
    
    public static var statusBarStyle: UIStatusBarStyle? {
        get {
            return UIApplication.shared.statusBarStyle
        }
        set {
            if let style = newValue {
                UIApplication.shared.statusBarStyle = style
            }
        }
    }
    
    public static var isStatusBarHidden: Bool {
        get {
            return UIApplication.shared.isStatusBarHidden
        }
        set {
            UIApplication.shared.isStatusBarHidden = newValue
        }
    }
    
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
}
#endif

#endif

