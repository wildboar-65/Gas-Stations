//
//  CreateAccountViewController.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFildDelegates()
        
    }
    func textFieldСorrectness() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
             return "All fields must be filled"
        }         
        let passwordCorect = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if !passwordCorect!.stringPasswordСorresponds() {
            return "Password must least 8 characters, contains character and a number."
        }
        return nil
    }
    @IBAction func createAndLogIn(_ sender: Any) {
        let textFieldError = textFieldСorrectness()
        
        if textFieldError != nil {
            showErrorMessage(text: textFieldError!)
        }else{
            let emailCorrect = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordCorrect = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
            Auth.auth().createUser(withEmail: emailCorrect, password: passwordCorrect) { (result, error) in
                if error != nil {
                    self.showErrorMessage(text: "Oops! Account not created")
                }else{
                    self.openGasStationController()
                }
            }
        }
    }
    func openGasStationController(){
        UserSettings.isLogIn = true
        let gasStationViewController = self.storyboard?.instantiateViewController(identifier: GlobalConstants.Storyboard.gasStationVCID) as? UINavigationController
        self.view.window?.rootViewController = gasStationViewController
        self.view.window?.makeKeyAndVisible()
    }
    func textFildDelegates(){
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    func showErrorMessage(text: String){
        errorLabel.text = text
        errorLabel.isHidden = false
        
    }
}
