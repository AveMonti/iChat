//
//  FinishRegistrationViewController.swift
//  iChat
//
//  Created by Mateusz Chojnacki on 19.06.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit
import ProgressHUD

class FinishRegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var email: String!
    var password: String!
    var avatarImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(email)
        print(password)
    }

    
    //MARK: IBActions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dissmissKeyboard()
        self.cleanTextFields()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        self.dissmissKeyboard()
        ProgressHUD.show("Registering...")
        if(self.ifNotEmptyTextField()){
            FUser.registerUserWith(email: email!, password: password!, firstName: self.nameTextField.text!, lastName: self.surnameTextField.text!) { (error) in
                if(error != nil){
                    ProgressHUD.dismiss()
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                self.registerUser()
            }
        }else{
            ProgressHUD.showError("All fields are required!")
        }
        
    }
    
    //MARK: HelperFunctions
    
    func registerUser(){
        let fullName = self.nameTextField.text! + " " + self.surnameTextField.text!
        var tempDictionary: Dictionary = [
            kFIRSTNAME : self.nameTextField.text!,
            kLATITUDE : self.surnameTextField.text!,
            kFULLNAME : fullName,
            kCOUNTRY : self.countryTextField.text!,
            kCITY: self.cityTextField.text!,
            kPHONE: self.phoneTextField.text!
        ] as [String : Any]
        
        if(self.avatarImage == nil){
            imageFromInitials(firstName: self.nameTextField.text!, lastName: self.surnameTextField.text!) { (avatarInitials) in
                let avatarIMG = avatarInitials
                
            }
        }else{
            
        }
    }
    
    func ifNotEmptyTextField() -> Bool{
        if(self.nameTextField.text != "" && self.surnameTextField.text != "" && self.countryTextField.text != "" && self.cityTextField.text != "" && self.phoneTextField.text != ""){
            return true;
        }else{
            return false;
        }
    }
    
    func dissmissKeyboard(){
        self.view.endEditing(false)
    }
    
    func cleanTextFields(){
        self.nameTextField.text = ""
        self.surnameTextField.text = ""
        self.countryTextField.text = ""
        self.cityTextField.text = ""
        self.phoneTextField.text = ""
    }
    
}
