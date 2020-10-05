//
//  CNGSTextFieldDelegate.swift
//  Gas Stations
//
//  Created by WildBoar on 04.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import AnyFormatKit

extension CreateNewGasStationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter = DefaultTextInputFormatter(textPattern: "##.##")
        if textField == priceTextField {
            let result = formatter.formatInput(currentText: textField.text!, range: range, replacementString: string)
                textField.text = result.formattedText
        }
        return false
    }
}
