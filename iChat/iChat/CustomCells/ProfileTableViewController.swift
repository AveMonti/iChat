//
//  ProfileTableViewController.swift
//  iChat
//
//  Created by Mateusz Chojnacki on 26.06.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var messageButtonOutlet: UIButton!
    @IBOutlet weak var callButtonOutlet: UIButton!
    @IBOutlet weak var blockUserOutlet: UIButton!
    
    
    var user:FUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    
    //MARK: IBActions
    
    
    @IBAction func callButtonPressed(_ sender: Any) {
    }
    
    @IBAction func chatButtonPressed(_ sender: Any) {
    }
    
    @IBAction func blockUserButtonPressed(_ sender: Any) {
        
    }
    
    //MARK: helper methods

    func setUpUI(){
        if self.user != nil{
            self.title = "Profile"
            self.fullNameLabel.text = self.user!.fullname
            self.phoneNumberLabel.text = self.user!.phoneNumber
            
            self.updateBlockStatus()
            
            imageFromData(pictureData: self.user!.avatar) { (avatarImage) in
                if avatarImage != nil{
                    self.avatarImageView.image = avatarImage!.circleMasked
                }
            }
        }
    }

    func updateBlockStatus(){
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 30
    }



}
