//
//  WelcomeViewController.swift
//  iChat
//
//  Created by Mateusz Chojnacki on 18.06.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.dissmissKeyboard()
    }
    @IBAction func registerButtonPress(_ sender: Any) {
        self.dissmissKeyboard()
    }
    
    @IBAction func backgroundTap(_ sender: Any) {
        self.dissmissKeyboard()
    }
    
    //MARK: HelperFunctions
    
    func dissmissKeyboard(){
        self.view.endEditing(false)
    }
    
    func cleanTextFields(){
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.repeatPasswordTextField.text = ""
    }
    
}
