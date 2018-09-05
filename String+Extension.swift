//
//  String+Extension.swift
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

public extension String {
    
    public var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    public var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    public func localized(table: String? = nil, bundle: Bundle = .main) -> String {
        return NSLocalizedString(self, tableName: table, bundle: bundle, value: self, comment: "")
    }
    
    public func localized(table: String? = nil, bundle: Bundle = .main, args: CVarArg...) -> String {
        let format: String = NSLocalizedString(
            self, tableName: table, bundle: bundle, value: self, comment: "")
        
        return String(format: format, arguments: args)
    }
    
    public func length() -> Int {
        return count
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public func substring(location: Int, length: Int) -> String! {
        var location = location
        if location >= self.length() {
            return ""
        }
        
        while location < 0 {
            location += self.length()
        }
        
        return (self as NSString).substring(with: NSMakeRange(location, length))
    }
    
    public func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted).location == NSNotFound
    }
    
    public func contains(_ string: String) -> Bool {
        if (self.range(of: string) != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    public func contains(_ string:String, withCompareOptions compareOptions: NSString.CompareOptions) -> Bool {
        if ((self.range(of:string, options: compareOptions)) != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    public func reverse() -> String {
        return String(self.reversed())
    }
    
    subscript(index: Int) -> String! {
        get {
            return self.substring(location: index, length: 1)
        }
    }
    
    public func location(substring: String) -> Int {
        return (self as NSString).range(of: substring).location
    }
    
    public func contains(substring: String) -> Bool {
        return (self as NSString).contains(substring)
    }
}

public extension String {
    
    public func isEmail() -> Bool {
        let regEx = "^(?=^.{6,32}$)(\\w+([-.]\\w+)*@\\w+([-.]\\w+)*\\.\\w{2,}([-.]\\w+)*$)"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    public func isLatinNumeric() -> Bool {
        if self.isEmpty {
            return true
        }
        
        let regEx = "^[a-zA-Z0-9]{0,}"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    public func isLatinNumericEmail() -> Bool {
        if self.isEmpty {
            return true
        }
        
        let regEx = "^[a-zA-Z0-9.@_-]{0,}"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    // Password must be more than 6 characters, with at least one capital, numeric character.
    public func isValidPassword() -> Bool {
        let regEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,12}$"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
}

public extension String {
    
    public var htmlToNSAttributedString: NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        }
        catch {
            return NSAttributedString()
        }
    }
    
    public func capitalizedFirst() -> String {
        let first = self[self.startIndex ..< self.index(startIndex, offsetBy: 1)]
        let rest = self[self.index(startIndex, offsetBy: 1) ..< self.endIndex]
        return first.uppercased() + rest.lowercased()
    }
    
    public func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

#if os(iOS) || os(tvOS)
import UIKit

public extension String {
    
    public func heightForString(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedStringKey.font: font],
                                     context: nil)
        
        return ceil(rect.height)
    }
    
    public func sizeForWidth(width: CGFloat, font: UIFont) -> CGSize {
        let attr = [NSAttributedStringKey.font: font]
        
        let size =  CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let height = NSString(string: self).boundingRect(with: size,
                                                         options:.usesLineFragmentOrigin,
                                                         attributes: attr, context: nil).height
        
        return CGSize(width: width, height: ceil(height))
    }
}
#endif
