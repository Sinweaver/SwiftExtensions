//
//  Array+Extension.swift
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

public extension Array {
    
    public func get(index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}

public extension Array where Element: Equatable {
    public func contains(_ item: Element) -> Bool {
        return indexOf(item: item) != nil
    }
    
    public func indexOf(item: Element) -> Int? {
        for (index, itemToCompare) in self.enumerated() {
            if item == itemToCompare {
                return index
            }
        }
        return nil
    }
    
    public func difference(arrays: [Element]...) -> [Element] {
        var result: [Element] = []
        
        items: for item in self {
            for array in arrays {
                if array.contains(item) {
                    continue items
                }
            }
            
            result.append(item)
        }
        
        return result
    }
    
    public func intersection(arrays: [Element]...) -> [Element] {
        var result = self
        var intersection: [Element] = []
        
        for (i, array) in arrays.enumerated() {
            if (i > 0) {
                result = intersection
                intersection = []
            }
            
            array.forEach { (item) in
                if result.contains(item) {
                    intersection.append(item)
                }
            }
        }
        
        return intersection
    }
    
    public func union(arrays: [Element]...) -> [Element] {
        var result = self
        
        for array in arrays {
            for item in array {
                if !result.contains(item) {
                    result.append(item)
                }
            }
        }
        
        return result
    }
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
