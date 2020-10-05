//
//  UIViewControllerExtension.swift
//  Gas Stations
//
//  Created by WildBoar on 04.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tapForCloseKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapForCloseKeyboard.cancelsTouchesInView = false
        view.addGestureRecognizer(tapForCloseKeyboard)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
