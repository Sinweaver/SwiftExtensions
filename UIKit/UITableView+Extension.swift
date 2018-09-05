//
//  UITableView+Extension.swift
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

public extension UITableView {
    
    public var indexPathForLastRow: IndexPath? {
        return indexPathForLastRow(inSection: lastSection)
    }

    public var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }
    
    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    public func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    public func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    public func removeTableFooterView() {
        tableFooterView = nil
    }
    
    public func removeTableHeaderView() {
        tableHeaderView = nil
    }
    
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    
    public func reloadRowsInSection(section: Int, oldCount:Int, newCount: Int) {
        
        let maxCount = max(oldCount, newCount)
        let minCount = min(oldCount, newCount)
        
        var changed = [IndexPath]()
        
        for i in minCount..<maxCount {
            let indexPath = IndexPath(row: i, section: section)
            changed.append(indexPath)
        }
        
        var reload = [IndexPath]()
        for i in 0..<minCount{
            let indexPath = IndexPath(row: i, section: section)
            reload.append(indexPath)
        }
        
        beginUpdates()
        if(newCount > oldCount){
            insertRows(at: changed, with: .fade)
        }
        else if(oldCount > newCount){
            deleteRows(at: changed, with: .fade)
        }
        
        if(newCount > oldCount || newCount == oldCount) {
            reloadRows(at: reload, with: .none)
        }
        endUpdates()
    }
}

#endif
