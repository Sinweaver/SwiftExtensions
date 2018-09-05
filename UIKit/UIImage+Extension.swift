//
//  UIImage+Extension.swift
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

public extension UIImage {
    
    public var bytesSize: Int {
        return UIImageJPEGRepresentation(self, 1)?.count ?? 0
    }
    
    public var kilobytesSize: Int {
        return bytesSize / 1024
    }
 
    public var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    public var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
}

extension UIImage {
    
     public class func imageWith(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public func imageCroppedToRect(rect: CGRect) -> UIImage? {
        let rect: CGRect = CGRect(x: -rect.origin.x,
                           y: -rect.origin.y,
                           width: size.width,
                           height: size.height)
        
        return _imageToRect(rect: rect)
    }
    
    public func imageCroppedToFill(size: CGSize) -> UIImage? {
        let factor: CGFloat = max(size.width / self.size.width,
                                  size.height / self.size.height)
        
        let rect: CGRect = CGRect(x: (size.width - self.size.width * factor) / 2.0,
                          y: (size.height - self.size.height * factor) / 2.0,
                          width: self.size.width * factor,
                          height: self.size.height * factor)
        
        return _imageToRect(rect: rect)
    }
    
    public func imageDonwsizedToFill(size: CGSize) -> UIImage? {
        let factor: CGFloat = max(size.width / self.size.width,
                                  size.height / self.size.height)
        
        let rect: CGRect = CGRect(x: 0.0,
                                  y: 0.0,
                                  width: self.size.width * factor,
                                  height: self.size.height * factor)
        
        return _imageToRect(rect: rect)
    }

    public func imageDonwsizedToFit(size: CGSize) -> UIImage? {
        let factor: CGFloat = min(size.width / self.size.width,
                                  size.height / self.size.height)
        
        let rect: CGRect = CGRect(x: 0.0,
                                  y: 0.0,
                                  width: self.size.width * factor,
                                  height: self.size.height * factor)
        
        return _imageToRect(rect: rect)
    }
    
    public func imageDownsizedByFactor(factor: CGFloat) -> UIImage? {
        if factor >= 1.0 {
            return self
        }
        
        let rect: CGRect = CGRect(x: 0.0,
                                  y: 0.0,
                                  width: self.size.width * factor,
                                  height: self.size.height * factor)
        
        return _imageToRect(rect: rect)
    }
    
    public func flipImageHorizontally() -> UIImage? {
        guard let cgImage = cgImage else {
            return self
        }
        
        return UIImage(cgImage: cgImage, scale: scale, orientation: UIImageOrientation.upMirrored)
    }
    
    public func flipImageVertically() -> UIImage? {
        guard let cgImage = cgImage else {
            return self
        }
        
        return UIImage(cgImage: cgImage, scale: scale, orientation: UIImageOrientation.leftMirrored)
    }
    
    fileprivate func _imageToRect(rect: CGRect) -> UIImage? {
        if UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale)) {
            UIGraphicsBeginImageContextWithOptions(rect.size, true, self.scale)
        }
        else {
            UIGraphicsBeginImageContext(rect.size)
        }
        
        self.draw(in: rect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}

public extension UIImage {
    
    public class func getCurrentLaunchImage() -> UIImage? {
        
        guard let launchImages = Bundle.main.infoDictionary?["UILaunchImages"] as? [[String: Any]] else {
            return nil
        }
        
        let screenSize = UIScreen.main.bounds.size
        
        for launchImage in launchImages {
            
            guard let imageSize = launchImage["UILaunchImageSize"] as? String else { continue }
            let launchImageSize = CGSizeFromString(imageSize)
            
            if launchImageSize.equalTo(screenSize),
                let launchImageName = launchImage["UILaunchImageName"] as? String {
                return UIImage(named: launchImageName)
            }
        }
        
        return nil
    }
}

#endif
