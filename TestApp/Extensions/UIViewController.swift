//
//  UIViewController.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-24.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: ALERTS
    
    public func alert(title: String, message: String, _ handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func confirm(title: String, message: String, _ confirmation: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            confirmation()
        }
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
