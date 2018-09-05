//
//  UIDevice+Extension.swift
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

public extension UIDevice {
    
    public static var osVersion: String {
        return UIDevice.current.systemVersion
    }
    
    public static var osName: String {
        return UIDevice.current.systemName
    }
    
    public static var cpuFrequency: Int {
        return self.getSysInfo(HW_CPU_FREQ)
    }
    
    public static var busFrequency: Int {
        return self.getSysInfo(HW_TB_FREQ)
    }
    
    public static var ramSize: Int {
        return self.getSysInfo(HW_MEMSIZE)
    }

    public static var cpusNumber: Int {
        return self.getSysInfo(HW_NCPU)
    }
    
    public static var totalMemory: Int {
        return self.getSysInfo(HW_PHYSMEM)
    }
    
    public static var userMemory: Int {
        return self.getSysInfo(HW_USERMEM)
    }
    
    public static func uptime() -> TimeInterval {
        return ProcessInfo.processInfo.systemUptime
    }
    
    public static func uptimeDate() -> Date {
        return Date(timeIntervalSinceNow: -uptime())
    }
    
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public static var isAppleTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    
    public static func totalDiskSpace() -> NSNumber {
        do {
            let attributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            return attributes[.systemSize] as? NSNumber ?? NSNumber(value: 0.0)
        }
        catch {
            return NSNumber(value: 0.0)
        }
    }
    
    public static func freeDiskSpace() -> NSNumber {
        do {
            let attributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            return attributes[.systemFreeSize] as? NSNumber ?? NSNumber(value: 0.0)
        } catch {
            return NSNumber(value: 0.0)
        }
    }
    
    public static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    public static func isJailbroken() -> Bool {
        let canReadBinBash = FileManager.default.fileExists(atPath: "/bin/bash")
        if let canOpenCydia = (UIApplication.value(forKey: "sharedApplication") as? UIApplication)?.canOpenURL(URL(string: "cydia://")!) {
            return canOpenCydia || canReadBinBash
        }
        else {
            return canReadBinBash
        }
    }
    
    public static var hardwareModel: String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var nameCopy = name
        var size: Int = 2
        sysctl(&nameCopy, 2, nil, &size, &name, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&nameCopy, 2, &hw_machine, &size, &name, 0)
        
        let hardware: String = String(cString: hw_machine)
        return hardware
    }
    
    @available(iOS 9.0, *)
    public static var isLowPowerModeEnabled: Bool {
        return ProcessInfo.processInfo.isLowPowerModeEnabled
    }
    
    fileprivate static func getSysInfo(_ typeSpecifier: Int32) -> Int {
        var name: [Int32] = [CTL_HW, typeSpecifier]
        var nameCopy = name
        var size: Int = 2
        sysctl(&nameCopy, 2, nil, &size, &name, 0)
        var results: Int = 0
        sysctl(&nameCopy, 2, &results, &size, &name, 0)
        
        return results
    }
}

#if os(iOS)
public extension UIDevice {
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }
}
#endif

#endif
