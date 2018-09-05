//
//  UIFont+Extension.swift
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

public extension UIFont {
    
    public static func registerFonts(forResourcesOfType ext: String?) {
        // Register Fonts
        let paths = Bundle.main.paths(forResourcesOfType: ext, inDirectory: "")
        for path in paths {
            let url = NSURL(fileURLWithPath: path as String)
            var errorRef: Unmanaged<CFError>?
            CTFontManagerRegisterFontsForURL(url, .process, &errorRef)
        }
    }
    
    public static func calculateHeight(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        var size: CGSize = CGSize.zero
        if text.count > 0 {
            let frame: CGRect = text.boundingRect(
                with: CGSize(width: width, height: 999999),
                options: .usesLineFragmentOrigin,
                attributes: [NSAttributedStringKey.font: font], context: nil)
            
            size = CGSize(width: frame.size.width, height: frame.size.height + 1)
        }
        return size.height
    }
    
    public static func calculateHeight(width: CGFloat, font: String, fontSize: CGFloat, text: String) -> CGFloat {
        guard let font: UIFont = UIFont(name: font, size: fontSize) else {
            return 0.0
        }
        
        return self.calculateHeight(width: width, font: font, text: text)
    }
    
    public class func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName )
            print("Font Names = [\(names)]")
        }
    }
}

#endif
