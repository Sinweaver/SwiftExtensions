//
//  UILabel+Extension.swift
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

public extension UILabel {
    
    public func calculateHeight() -> CGFloat {
        guard let text = self.text else {
            return 0
        }
        return UIFont.calculateHeight(width: self.frame.size.width, font: self.font, text: text)
    }
    
    //    public func setFont(_ font: UIFont, fromIndex: Int, toIndex: Int) {
    //        guard let text = self.text else {
    //            return
    //        }
    //
    //        self.attributedText = text.attributedString.font(font, range: NSRange(location: fromIndex, length: toIndex - fromIndex))
    //    }
    //
    //    public func setFont(_ font: FontName, fontSize: CGFloat, fromIndex: Int, toIndex: Int) {
    //        guard let text = self.text else {
    //            return
    //        }
    //
    //        self.attributedText = text.attributedString.font(UIFont(fontName: font, size: fontSize), range: NSRange(location: fromIndex, length: toIndex - fromIndex))
    //    }
    
    //    public class func numberOfLinesInLabel(text: String?, width: CGFloat, font: UIFont) -> Int {
    //
    //        if text == nil || width == 0 {
    //            return 0
    //        }
    //
    //        let paragraphStyle = NSMutableParagraphStyle()
    //        paragraphStyle.minimumLineHeight = CGFloat.greatestFiniteMagnitude
    //        paragraphStyle.maximumLineHeight = CGFloat.greatestFiniteMagnitude
    //        paragraphStyle.lineBreakMode = .byWordWrapping
    //
    //        let attributes: [String: AnyObject] = [NSAttributedStringKey.font.rawValue: font,
    //                                               NSAttributedStringKey.paragraphStyle.rawValue: paragraphStyle]
    //
    //        let constrain = CGSize(width: width, height: CGFloat(Float.infinity))
    //
    //        let size = text!.size(withAttributes: attributes)
    //        let stringWidth = size.width
    //
    //        let numberOfLines = ceil(Double(stringWidth/constrain.width))
    //
    //        return Int(numberOfLines)
    //    }
    
    //    func isTruncated() -> Bool {
    //
    //        if let string = self.text {
    //
    //            let paragraphStyle = NSMutableParagraphStyle()
    //            paragraphStyle.lineBreakMode = .byWordWrapping
    //
    //            let attributes: [String: AnyObject] = [NSAttributedStringKey.font.rawValue: font,
    //                                                   NSAttributedStringKey.paragraphStyle.rawValue: paragraphStyle]
    //
    //            let size: CGSize = (string as NSString).boundingRect(
    //                with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude),
    //                options: NSStringDrawingOptions.usesLineFragmentOrigin,
    //                attributes: attributes,
    //                context: nil).size
    //
    //            return (size.height > self.bounds.size.height)
    //        }
    //
    //        return false
    //    }
}

#endif
