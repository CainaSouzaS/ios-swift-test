//
//  DataSource.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import Foundation

protocol DataSource: class {
    associatedtype T
    
    var items: [T] { get }
    var count: Int { get }
    
    func item(at index: Int) -> T
}

extension DataSource {
    
    var count: Int {
        return items.count
    }
    
    func item(at index: Int) -> T {
        return items[index]
    }
}
