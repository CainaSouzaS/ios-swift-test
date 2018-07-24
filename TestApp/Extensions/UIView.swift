//
//  UIView.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import UIKit

extension UIView {
    
    /// MARK: ANIMATIONS

    func bounceIn() {
        self.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func bounceOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }, completion: { finished in
            self.alpha = 0
            self.isHidden = true
        })
    }
    
}
