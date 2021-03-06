//
//  SQLiteMapper.swift
//  BrcIot
//
//  Created by tian on 2018/12/11.
//  Copyright © 2018 tian. All rights reserved.
//

import UIKit

public class SQLiteMapper {
    
    fileprivate var primaryKey: Int? = nil
    fileprivate var uniqueKeys: [Int] = []
    
    fileprivate func setPrimaryKey<T>(property: inout T) {
        let pointer = withUnsafePointer(to: &property, { return $0 })
        if self.primaryKey == nil {
            self.primaryKey = pointer.hashValue
        } else {
            print("table has pirmary key already")
        }
    }
    
    internal func isPrimary(key: Int) -> Bool {
        return self.primaryKey == key
    }
    
    fileprivate func setUniqueKeys<T>(property: inout T) {
        let pointer = withUnsafePointer(to: &property, { return $0 })
        self.uniqueKeys.append(pointer.hashValue)
    }
    
    internal func isUnique(key: Int) -> Bool {
        return self.uniqueKeys.contains(key)
    }
}

infix operator <<- : AssignmentPrecedence

public func <<- <T> (mapper: SQLiteMapper, attribute: inout T) {
    mapper.setPrimaryKey(property: &attribute)
}

infix operator <~~ : AssignmentPrecedence

public func <~~ <T> (mapper: SQLiteMapper, attribute: inout T) {
    mapper.setUniqueKeys(property: &attribute)
}
