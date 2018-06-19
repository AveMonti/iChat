//
//  WelcomeViewController.swift
//  iChat
//
//  Created by Mateusz Chojnacki on 18.06.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit
import ProgressHUD

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
        if self.emailTextField.text != "" && self.passwordTextField.text != ""{
            self.loginUser()
        } else {
            ProgressHUD.showError("Email and Password is missing!")
        }

    }
    
    @IBAction func registerButtonPress(_ sender: Any) {
        self.dissmissKeyboard()
        
        if self.emailTextField.text != "" && self.passwordTextField.text != "" && self.repeatPasswordTextField.text != ""{
            
            if self.passwordTextField.text == self.repeatPasswordTextField.text{
                self.registerUser()
            }else{
                ProgressHUD.showError("Password dont match!")
            }
            
            
        } else {
            ProgressHUD.showError("All fields are required!")
        }
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
    
    func loginUser(){
        ProgressHUD.show("Login...")
        FUser.loginUserWith(email: self.emailTextField.text!,
                            password: self.passwordTextField.text!) { (error) in
                                if(error) != nil{
                                    ProgressHUD.showError(error!.localizedDescription)
                                    return
                                }
                                self.goToApp()
        }
    }
    
    //MARK: GoToApp
    
    func goToApp(){
        ProgressHUD.dismiss()
        self.cleanTextFields()
        self.dissmissKeyboard()
        
        print("show the app")
        //present app here
    }
    
    func registerUser(){
        performSegue(withIdentifier: "welecomeToFinishRegistration", sender: self)
        self.cleanTextFields()
        self.dissmissKeyboard()
    }
    
    //MARK: Navigatiom
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "welecomeToFinishRegistration"{
            let vc = segue.destination as! FinishRegistrationViewController
            vc.email = emailTextField.text!
            vc.password = passwordTextField.text!
        }
    }
}
