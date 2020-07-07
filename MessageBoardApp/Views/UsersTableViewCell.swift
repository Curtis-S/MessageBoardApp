//
//  TableViewCell.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
     @IBOutlet var nameLabel: UILabel!
     @IBOutlet var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImage.roundImage()
 
    }

    func configure(withUser user: User) {
       nameLabel.text = user.name
    }
    
}

extension UIImageView {
      func roundImage (){
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
       }
    
}
