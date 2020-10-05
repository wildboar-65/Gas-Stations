//
//  LogInViewController.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeTextFieldDelegate()
    }
        //MARK: Get Error message when one of text field empty
    func textFieldСorrectness() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "All fields must be filled"
        }
        return nil
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        
        let textFieldError = textFieldСorrectness()
        
        if textFieldError != nil {
            showErrorMessage(text: textFieldError!)
        }else{
            let correctEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordCorrect = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: correctEmail, password: passwordCorrect) { (result, error) in
                if error != nil{
                    self.showErrorMessage(text: error!.localizedDescription)
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
    func showErrorMessage(text: String){
        errorLabel.text = text
        errorLabel.isHidden = false
        
    }
    func subscribeTextFieldDelegate(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
}
