//
//  Dictionary+Extension.swift
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
import Swift

public extension Dictionary {
    
    public func has(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    public static func constructFromJSON(json: String) -> Dictionary? {
        if let data = (try? JSONSerialization.jsonObject(
            with: json.data(using: String.Encoding.utf8,
                            allowLossyConversion: true)!,
            options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary {
            return data
        }
        else {
            return nil
        }
    }
    
    public func formatJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(
            withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(
                rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
}

public extension Dictionary where Value: Equatable {
    public func difference(dictionaries: [Key: Value]...) -> [Key: Value] {
        var result: [Key: Value] = self
        
        for dictionary in dictionaries {
            for (key, value) in dictionary {
                if result.has(key) && result[key] == value {
                    result.removeValue(forKey: key)
                }
            }
        }
        
        return result
    }
    
    public func union(dictionaries: [Key: Value]...) -> [Key: Value] {
        var result: [Key: Value] = self
        
        for dictionary in dictionaries {
            for (key, value) in dictionary {
                result[key] = value
            }
        }
        
        return result
    }
    
    func intersection(dictionaries: [Key: Value]...) -> [Key: Value] {
        var result: [Key: Value] = [:]
        
        for (key, value) in self {
            var needAdd: Bool = true
            
            for dictionary in dictionaries {
                if !dictionary.has(key) {
                    needAdd = false
                    break
                }
            }
            
            if needAdd {
                result[key] = value
            }
        }
        
        return result
    }
}
