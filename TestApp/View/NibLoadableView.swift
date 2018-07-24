//
//  NibLoadableView.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? NSStringFromClass(self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
}
