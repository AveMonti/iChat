//
//  UserTableViewCell.swift
//  iChat
//
//  Created by Mateusz Chojnacki on 25.06.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit


protocol UserTableViewCellDelegate {
    func didTapAvatarImage(indexPath: IndexPath)
}

class UserTableViewCell: UITableViewCell {

    var delegate: UserTableViewCellDelegate?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    var indexPath: IndexPath!
    let tabGestureRecognizer = UITapGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tabGestureRecognizer.addTarget(self, action: #selector(self.avatarTap))
        self.avatarImageView.isUserInteractionEnabled = true
        self.avatarImageView.addGestureRecognizer(self.tabGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func generateCellWith(fUser: FUser, indexPath: IndexPath){
        self.indexPath = indexPath
        self.fullNameLabel.text = fUser.fullname
        
        if fUser.avatar != ""{
            imageFromData(pictureData: fUser.avatar) { (avatarImage) in
                if avatarImage != nil{
                    self.avatarImageView.image = avatarImage!.circleMasked
                }
            }
        }
    }
    
    @objc func avatarTap(){
        self.delegate!.didTapAvatarImage(indexPath: self.indexPath)
    }
    
}
