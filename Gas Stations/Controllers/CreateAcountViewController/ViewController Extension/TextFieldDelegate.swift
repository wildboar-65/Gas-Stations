//
//  TextFieldDelegate.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit


extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
