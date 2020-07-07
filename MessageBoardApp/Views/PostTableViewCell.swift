//
//  PostTableViewCell.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var mainText: UILabel!
    
    @IBOutlet weak var commentNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

   func configure(withTitle: String ,andText:String) {
        mainText.text = withTitle
        commentNumber.text = andText
      }
    
}
