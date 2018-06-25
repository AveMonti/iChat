//
//  chatsViewController.swift
//  iChat
//
//  Created by Mateusz Chojnacki on 25.06.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: IBAction
    @IBAction func createNewChatButtonPressed(_ sender: Any) {
        
        let userVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersTableView") as! UsersTableViewController
        self.navigationController?.pushViewController(userVC, animated: true)
        
    }
}
