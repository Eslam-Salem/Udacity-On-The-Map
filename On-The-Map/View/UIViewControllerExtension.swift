//
//  UIViewControllerExtension.swift
//  On-The-Map
//
//  Created by Eslam  on 5/3/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func raiseAlertView(withTitle: String, withMessage: String) {
        
        let alertController = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
