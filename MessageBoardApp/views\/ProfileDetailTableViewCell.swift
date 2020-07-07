//
//  ProfileDetailTableViewCell.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import UIKit

class ProfileDetailTableViewCell: UITableViewCell {

 
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func configure(withTitle: String ,andText:String) {
        self.textLabel?.text = withTitle
        self.detailTextLabel?.text = andText
    }
    
    
}
