//
//  UsersTableViewController.swift
//  iChat
//
//  Created by Mateusz Chojnacki on 25.06.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class UsersTableViewController: UITableViewController, UISearchResultsUpdating {
    

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterSegmentedControll: UISegmentedControl!
    
    var allUsers: [FUser] = []
    var fillterdUsers: [FUser] = []
    var allUsersGroupped = NSDictionary() as! [String: [FUser]]
    var sectionTitleList: [String] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        navigationItem.largeTitleDisplayMode = .never
        tableView.tableFooterView = UIView()
        
        loadUsers(fillter: kCITY)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell

        cell.generateCellWith(fUser: allUsers[indexPath.row], indexPath: indexPath)

        return cell
    }
    
    
    func loadUsers(fillter: String){
        
        ProgressHUD.show()
        
        var query: Query!
        switch fillter {
        case kCITY:
            query = reference(.User).whereField(kCITY, isEqualTo: FUser.currentUser()!.city).order(by: kFIRSTNAME, descending: false)
        case kCOUNTRY:
            query = reference(.User).whereField(kCITY, isEqualTo: FUser.currentUser()!.country).order(by: kFIRSTNAME, descending: false)
        default:
            query = reference(.User).order(by: kFIRSTNAME, descending: false)
        }
        
        query.getDocuments { (snapshot, error) in
            self.allUsers = []
            self.sectionTitleList = []
            self.allUsersGroupped = [:]
            
            if error != nil{
                print(error!.localizedDescription)
                ProgressHUD.dismiss()
                self.tableView.reloadData()
                return
            }
            
            guard let snapshot = snapshot else{
                ProgressHUD.dismiss()
                return
            }
            
            if !snapshot.isEmpty {
                for userDictionary in snapshot.documents{
                    let userDictionary = userDictionary.data() as NSDictionary
                    let fUser = FUser(_dictionary: userDictionary)
                    if fUser.objectId != FUser.currentId(){
                        self.allUsers.append(fUser)
                    }
                }
                //split to groups
            }
            self.tableView.reloadData()
            ProgressHUD.dismiss()
        }
        
    }
    // MARK: - IBActions
    
    @IBAction func filterSegmentValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            loadUsers(fillter: kCITY)
        case 1:
            loadUsers(fillter: kCOUNTRY)
        case 2:
            loadUsers(fillter: "")
        default:
            return
        }
        
    }
    
    
    
    // MARK: - Search controller functions
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        
        self.fillterdUsers = allUsers.filter({ (user) -> Bool in
            return user.firstname.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchText: self.searchController.searchBar.text!)
    }

}
