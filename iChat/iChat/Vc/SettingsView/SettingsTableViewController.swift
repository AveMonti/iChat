//
//  SettingsTableViewController.swift
//  iChat
//
//  Created by Mateusz Chojnacki on 23.06.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - IBActions
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        FUser.logOutCurrentUser { (success) in
            if success {
                self.showLogInView()
            }
        }
    }
    
    func showLogInView(){
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome")
        
        self.present(mainView,animated: true,completion: nil)
    }
    
}
