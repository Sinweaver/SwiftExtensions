//
//  NSObject+Extension.swift
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
import ObjectiveC

public extension NSObject {
    
//    func ao_get(pkey: UnsafeRawPointer) -> Any? {
//        return objc_getAssociatedObject(self, pkey)
//    }
//
//    func ao_set(_ value: Any, pkey: UnsafeRawPointer, policy: AssociationPolicy = .retainNonatomic) {
//        objc_setAssociatedObject(self, pkey, value, policy.objc)
//    }
    
    
//    public func setAssociatedObject<T>(_ object: AnyObject, key: UnsafeRawPointer, value: T?,
//                                       policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN) {
//        
//        guard let value = value else {
//            objc_setAssociatedObject(object, key, nil, policy)
//            return
//        }
//        objc_setAssociatedObject(object, key, value, policy)
//    }
//    
//    private func getAssociatedObject<T>(object: AnyObject, key: UnsafeRawPointer) -> T? {
//        if let v = objc_getAssociatedObject(object, key) as? T {
//            return v
//        }
//        else if let v = objc_getAssociatedObject(object, key) as? AssociatedObjectBox<T> {
//            return v.value
//        }
//        else {
//            return nil
//        }
//    }
//    
//    class func swizzleMethodForSelector(originalSelector: Selector,
//                                        withMethodForSelector swizzledSelector: Selector) {
//        let originalMethod = class_getInstanceMethod(self, originalSelector)
//        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
//        
//        let didAddMethod = class_addMethod(self, originalSelector,
//                                           method_getImplementation(swizzledMethod),
//                                           method_getTypeEncoding(swizzledMethod))
//        
//        if didAddMethod {
//            class_replaceMethod(self, swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod))
//        }
//        else {
//            method_exchangeImplementations(originalMethod, swizzledMethod)
//        }
//    }
}
